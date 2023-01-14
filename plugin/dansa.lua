local dansa = require "dansa"
if vim.g.loaded_dansa then
  return
end
vim.g.loaded_dansa = true

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = vim.api.nvim_create_augroup('dansa', {
    clear = true,
  }),
  callback = function()
    local guess = dansa.guess(0)

    if #vim.tbl_keys(guess) == 0 then
      vim.bo[0].expandtab = dansa.config:get().default.expandtab
      if dansa.config:get().default.expandtab then
        vim.bo[0].shiftwidth = dansa.config:get().default.space.shiftwidth
      else
        vim.bo[0].shiftwidth = dansa.config:get().default.tab.shiftwidth
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
      vim.bo[0].expandtab = false
      vim.bo[0].shiftwidth = dansa.config:get().default.tab.shiftwidth
    else
      vim.o.expandtab = true
      vim.bo[0].shiftwidth = #current.indent
    end
  end
})
