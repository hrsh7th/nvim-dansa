local kit = require('dansa.kit')
local Config = require('dansa.kit.App.Config')
local Syntax = require('dansa.kit.Vim.Syntax')

---@class dansa.kit.App.Config.Schema
---@field public enabled boolean|fun(): boolean
---@field public cutoff_count integer
---@field public scan_offset integer
---@field public ignored_groups_pattern? string[]
---@field public default { expandtab: boolean, space: { shiftwidth: integer }, tab: { shiftwidth: integer } }

---@param a string
---@param b string
---@return string
local function get_space_indent_diff(a, b)
  if #a > #b then
    a, b = b, a
  end
  return (b:gsub('^' .. vim.pesc(a), ''))
end

local dansa = {
  config = Config.new({
    enabled = true,
    scan_offset = 100,
    cutoff_count = 5,
    default = {
      expandtab = true,
      space = {
        shiftwidth = 2,
      },
      tab = {
        shiftwidth = 4
      }
    },
    ignored_groups_pattern = { '.*comment.*', '.*string.*' }
  })
}

dansa.setup = dansa.config:create_setup_interface()

---Guess indent information.
---@param bufnr integer
---@return table<string, integer>
function dansa.guess(bufnr)
  local cur_row0 = vim.api.nvim_win_get_cursor(0)[1]
  local max_row0 = vim.api.nvim_buf_line_count(0) - 1
  local start_row = math.max(0, cur_row0 - dansa.config:get().scan_offset - 1)
  local end_row = 1 + math.min(max_row0, cur_row0 + dansa.config:get().scan_offset)
  local lines = vim.iter(ipairs(vim.api.nvim_buf_get_lines(bufnr, start_row, end_row, false))):map(function(i, line)
    return {
      row0 = start_row + i - 1,
      line = line,
    }
  end):totable()

  -- Remove blank lines.
  for i = #lines, 1, -1 do
    if lines[i].line == '' then
      table.remove(lines, i)
    end
  end

  ---@type table<string, integer>
  local guessing = {}
  for i = 2, #lines do
    local prev = lines[i - 1]
    local prev_line = prev.line
    local prev_white = prev_line:match('^%s+') or ''
    local is_prev_tab = not not prev_white:match('^\t+$')
    local curr = lines[i]
    local curr_line = curr.line
    local curr_white = curr_line:match('^%s+') or ''
    local is_curr_tab = not not curr_white:match('^\t+$')

    local in_ignored_group = false
    local groups = {}
    groups = kit.concat(groups, Syntax.get_treesitter_syntax_groups({ prev.row0, 0 }))
    for _, group in ipairs(groups) do
      for _, pattern in ipairs(dansa.config:get().ignored_groups_pattern or {}) do
        if group:lower():match(pattern) then
          in_ignored_group = true
          break
        end
      end
      if in_ignored_group then
        break
      end
    end

    if not in_ignored_group then
      if is_curr_tab then
        guessing['\t'] = guessing['\t'] or 0
        guessing['\t'] = guessing['\t'] + 1
      else
        if is_prev_tab then    -- tab -> space -> ?
          if lines[i + 1] then -- tab -> space -> ?
            local next = lines[i + 1]
            local next_line = next.line
            local next_white = next_line:match('^%s+') or ''
            local is_next_tab = not not next_white:match('^\t+$')
            if not is_next_tab then -- tab -> space -> space
              local diff = get_space_indent_diff(curr_white, next_white)
              if diff ~= '' then
                guessing[diff] = guessing[diff] or 0
                guessing[diff] = guessing[diff] + 1
              end
            else -- tab -> space -> tab
              -- ignore
            end
          else -- tab -> space -> none
            -- ignore
          end
        else -- space -> space
          local diff = get_space_indent_diff(prev_white, curr_white)
          if diff ~= '' then
            guessing[diff] = guessing[diff] or 0
            guessing[diff] = guessing[diff] + 1
          end
        end
      end
    end
  end

  local fixed_guessing = {}
  for indent, count in pairs(guessing) do
    if count >= dansa.config:get().cutoff_count then
      fixed_guessing[indent] = count
    end
  end
  return fixed_guessing
end

return dansa
