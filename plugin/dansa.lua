if vim.g.loaded_dansa then
  return
end
vim.g.loaded_dansa = true

local dansa = require "dansa"

local function enabled()
  local e = dansa.config:get()
  if type(e) == 'function' then
    return e()
  end
  return e
end

local function set(is_tab, shiftwidth)
  if is_tab then
    vim.bo[0].expandtab = false
    vim.bo[0].shiftwidth = shiftwidth
    vim.bo[0].tabstop = shiftwidth
  else
    vim.bo[0].expandtab = true
    vim.bo[0].shiftwidth = shiftwidth
    vim.bo[0].tabstop = shiftwidth
  end
end

local function apply()
  local guess = dansa.guess(0)

  if #vim.tbl_keys(guess) == 0 then
    vim.bo[0].expandtab = dansa.config:get().default.expandtab
    if dansa.config:get().default.expandtab then
      vim.bo[0].shiftwidth = dansa.config:get().default.space.shiftwidth
      vim.bo[0].tabstop = dansa.config:get().default.space.shiftwidth
    else
      vim.bo[0].shiftwidth = dansa.config:get().default.tab.shiftwidth
      vim.bo[0].tabstop = dansa.config:get().default.tab.shiftwidth
    end
    return
  end

  local current = { indent = '', count = -1 }
  for indent, count in pairs(guess) do
    if current.count < count then
      current.indent = indent
      current.count = count
    end
  end

  if current.indent == '\t' then
    set(true, dansa.config:get().default.tab.shiftwidth)
  else
    set(false, #current.indent)
  end
end

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = vim.api.nvim_create_augroup('dansa', {
    clear = true,
  }),
  callback = function()
    if enabled() then
      apply()
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
    apply()
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
