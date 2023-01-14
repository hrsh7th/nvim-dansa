local Config = require('dansa.kit.App.Config')

---@class dansa.kit.App.Config.Schema
---@field public threshold integer
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
    threshold = 100,
    default = {
      expandtab = false,
      space = {
        shiftwidth = 2,
      },
      tab = {
        shiftwidth = 4
      }
    }
  })
}

dansa.setup = dansa.config:create_setup_interface()

---Guess indent information.
---@param bufnr integer
---@return table<string, integer>
function dansa.guess(bufnr)
  local cur_row = vim.api.nvim_win_get_cursor(0)[1]
  local max_row = vim.api.nvim_buf_line_count(0)
  local lines = vim.api.nvim_buf_get_lines(
    bufnr,
    math.max(0, cur_row - dansa.config:get().threshold - 1),
    math.min(max_row, cur_row + dansa.config:get().threshold),
    false
  )

  -- Remove blank lines.
  for i = #lines, 1, -1 do
    if lines[i] == '' then
      table.remove(lines, i)
    end
  end

  ---@type table<string, integer>
  local guessing = {}
  for i = 2, #lines do
    local prev = lines[i - 1]
    local prev_white = prev:match('^%s+') or ''
    local is_prev_tab = not not prev_white:match('^\t+$')
    local curr = lines[i]
    local curr_white = curr:match('^%s+') or ''
    local is_curr_tab = not not curr_white:match('^\t+$')

    if is_curr_tab then
      guessing['\t'] = guessing['\t'] or 0
      guessing['\t'] = guessing['\t'] + 1
    else
      if is_prev_tab then -- tab -> space -> ?
        if lines[i + 1] then -- tab -> space -> ?
          local next = lines[i + 1]
          local next_white = next:match('^%s+') or ''
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
  return guessing
end

return dansa
