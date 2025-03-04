if vim.g.loaded_dansa then
  return
end
vim.g.loaded_dansa = true

local dansa = require "dansa"

---Get enabled
---@return boolean
local function enabled()
  local e = dansa.config:get()
  if type(e) == 'function' then
    return e()
  end
  return not not e
end

---Debug print
local function debug_print(...)
  if vim.g.dansa_debug then
    vim.print(...)
  end
end
vim.g.dansa_debug = false

---Set expandtab/shiftwidth/tabstop.
---@param bufnr integer
---@param is_tab boolean
---@param shiftwidth integer
local function set(bufnr, is_tab, shiftwidth)
  if is_tab then
    vim.bo[bufnr].expandtab = false
    vim.bo[bufnr].shiftwidth = shiftwidth
    vim.bo[bufnr].tabstop = shiftwidth
  else
    vim.bo[bufnr].expandtab = true
    vim.bo[bufnr].shiftwidth = shiftwidth
    vim.bo[bufnr].tabstop = shiftwidth
  end
end

---Apply indent settings for buf.
---@param bufnr integer
local function apply(bufnr)
  local guess = dansa.guess(bufnr)

  if #vim.tbl_keys(guess) == 0 then
    local is_editorconfig = type(vim.b.editorconfig) and vim.b.editorconfig or vim.g.editorconfig or true
    if is_editorconfig then
      debug_print({
        name = vim.api.nvim_buf_get_name(bufnr),
        type = 'editorconfig',
        guess = guess,
      })
      require('editorconfig').config(bufnr)
    else
      debug_print({
        name = vim.api.nvim_buf_get_name(bufnr),
        type = 'fallback',
        guess = guess,
      })
      vim.bo[bufnr].expandtab = dansa.config:get().default.expandtab
      if dansa.config:get().default.expandtab then
        vim.bo[bufnr].shiftwidth = dansa.config:get().default.space.shiftwidth
        vim.bo[bufnr].tabstop = dansa.config:get().default.space.shiftwidth
      else
        vim.bo[bufnr].shiftwidth = dansa.config:get().default.tab.shiftwidth
        vim.bo[bufnr].tabstop = dansa.config:get().default.tab.shiftwidth
      end
    end
    return
  end

  debug_print({
    name = vim.api.nvim_buf_get_name(bufnr),
    type = 'guess',
    guess = guess,
  })
  local current = { indent = '', count = -1 }
  for indent, count in pairs(guess) do
    if current.count < count then
      current.indent = indent
      current.count = count
    end
  end

  if current.indent == '\t' then
    set(bufnr, true, dansa.config:get().default.tab.shiftwidth)
  else
    set(bufnr, false, #current.indent)
  end
end

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = vim.api.nvim_create_augroup('dansa', {
    clear = true,
  }),
  callback = function()
    if enabled() then
      local bufnr = vim.api.nvim_get_current_buf()
      vim.schedule(function()
        apply(bufnr)
      end)
    end
  end
})

vim.api.nvim_create_user_command('Dansa', function(ctx)
  if ctx.fargs[1] == '8' then
    set(false, 8)
  elseif ctx.fargs[1] == '4' then
    set(false, 4)
  elseif ctx.fargs[1] == '2' then
    set(false, 2)
  elseif ctx.fargs[1] == 'tab' then
    set(true, 4)
  else
    apply(vim.api.nvim_get_current_buf())
  end
  vim.api.nvim_echo({
    { '[dansa]',                                'Special' },
    { ' ',                                      'Normal' },

    -- style.
    { 'style=',                                 'Normal' },
    { vim.bo[0].expandtab and 'space' or 'tab', 'String' },
    { ', ',                                     'Normal' },

    -- shiftwidth.
    { 'shiftwidth=',                            'Normal' },
    { tostring(vim.bo[0].shiftwidth),           'String' },
    { ', ',                                     'Normal' },

    -- tabstop.
    { 'tabstop=',                               'Normal' },
    { tostring(vim.bo[0].tabstop),              'String' },
  }, false, {})
end, {
  nargs = '*',
  complete = function()
    return {
      '8',
      '4',
      '2',
      'tab',
    }
  end
})
