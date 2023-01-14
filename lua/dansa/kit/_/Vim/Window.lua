---@class dansa.kit.Vim.Window
---@field public specifier dansa.kit.Vim.Window.Specifier
---@field public option table<string, string | integer | boolean>
---@field public win? integer
---@field public buf? integer
local Window = {}
Window.__index = Window

---@enum dansa.kit.Vim.Window.SplitDirection
Window.SplitDirection = {
  Top = 'top',
  Bottom = 'bottom',
  Left = 'left',
  Right = 'right',
  Current = 'current',
}

---@alias dansa.kit.Vim.Window.Specifier dansa.kit.Vim.Window.FloatSpecifier | dansa.kit.Vim.Window.SplitSpecifier

---@class dansa.kit.Vim.Window.FloatSpecifier
---@field public row integer 0-origin screen cell width
---@field public col integer 0-origin screen cell width
---@field public width integer 0-origin screen cell width
---@field public height integer 0-origin screen cell width

---@class dansa.kit.Vim.Window.SplitSpecifier
---@field public direction dansa.kit.Vim.Window.SplitDirection
---@field public width integer 0-origin screen cell width
---@field public height integer 0-origin screen cell width

---@param specifier dansa.kit.Vim.Window.Specifier
function Window.new(specifier)
  local self = setmetatable({}, Window)
  self.specifier = specifier
  self.option = {}
  return self
end

return Window
