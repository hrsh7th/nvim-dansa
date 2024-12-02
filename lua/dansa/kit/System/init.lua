-- luacheck: ignore 212

local kit = require('dansa.kit')
local Async = require('dansa.kit.Async')

local System = {}

---@class dansa.kit.System.Buffer
---@field write fun(data: string)
---@field close fun()

---@class dansa.kit.System.Buffering
---@field create fun(self: any, callback: fun(data: string)): dansa.kit.System.Buffer

---@class dansa.kit.System.LineBuffering: dansa.kit.System.Buffering
---@field ignore_empty boolean
System.LineBuffering = {}
System.LineBuffering.__index = System.LineBuffering

---Create LineBuffering.
---@param option { ignore_empty?: boolean }
function System.LineBuffering.new(option)
  return setmetatable({
    ignore_empty = option.ignore_empty or false,
  }, System.LineBuffering)
end

---Create LineBuffer object.
function System.LineBuffering:create(callback)
  local buffer = {}
  return {
    write = function(data)
      data = (data:gsub('\r\n?', '\n'))
      table.insert(buffer, data)

      local has = false
      for i = #data, 1, -1 do
        if data:sub(i, i) == '\n' then
          has = true
          break
        end
      end

      if has then
        local texts = vim.split(table.concat(buffer, ''), '\n')
        buffer = texts[#texts] ~= '' and { table.remove(texts) } or {}
        for _, text in ipairs(texts) do
          if self.ignore_empty then
            if text:gsub('^%s*', ''):gsub('%s*$', '') ~= '' then
              callback(text)
            end
          else
            callback(text)
          end
        end
      end
    end,
    close = function()
      if #buffer > 0 then
        callback(table.concat(buffer, ''))
      end
    end
  }
end

---@class dansa.kit.System.PatternBuffering: dansa.kit.System.Buffering
---@field pattern string
System.PatternBuffering = {}
System.PatternBuffering.__index = System.PatternBuffering

---Create PatternBuffering.
---@param option { pattern: string }
function System.PatternBuffering.new(option)
  return setmetatable({
    pattern = option.pattern,
  }, System.PatternBuffering)
end

---Create PatternBuffer object.
function System.PatternBuffering:create(callback)
  local buffer = {}
  return {
    write = function(data)
      table.insert(buffer, data)
      while true do
        local text = table.concat(buffer, '')
        local s, e = text:find(self.pattern)
        if s and e then
          callback(text:sub(1, s - 1))
          if e < #text then
            buffer = { text:sub(e + 1) }
          else
            buffer = {}
          end
        else
          break
        end
      end
    end,
    close = function()
      if #buffer > 0 then
        callback(table.concat(buffer, ''))
      end
    end
  }
end

---@class dansa.kit.System.RawBuffering: dansa.kit.System.Buffering
System.RawBuffering = {}
System.RawBuffering.__index = System.RawBuffering

---Create RawBuffering.
function System.RawBuffering.new()
  return setmetatable({}, System.RawBuffering)
end

---Create RawBuffer object.
function System.RawBuffering:create(callback)
  return {
    write = function(data)
      callback(data)
    end,
    close = function()
      -- noop.
    end
  }
end

---Spawn a new process.
---@class dansa.kit.System.SpawnParams
---@field cwd string
---@field input? string|string[]
---@field on_stdout? fun(data: string)
---@field on_stderr? fun(data: string)
---@field on_exit? fun(code: integer, signal: integer)
---@field buffering? dansa.kit.System.Buffering
---@param command string[]
---@param params dansa.kit.System.SpawnParams
---@return fun(signal?: integer)
function System.spawn(command, params)
  command = vim
      .iter(command)
      :filter(function(c)
        return c ~= nil
      end)
      :totable()

  local cmd = command[1]
  local args = {}
  for i = 2, #command do
    table.insert(args, command[i])
  end

  local env = vim.fn.environ()
  env.NVIM = vim.v.servername
  env.NVIM_LISTEN_ADDRESS = nil

  local env_pairs = {}
  for k, v in pairs(env) do
    table.insert(env_pairs, string.format('%s=%s', k, tostring(v)))
  end

  local buffering = params.buffering or System.RawBuffering.new()
  local stdout_buffer = buffering:create(function(text)
    if params.on_stdout then
      params.on_stdout(text)
    end
  end)
  local stderr_buffer = buffering:create(function(text)
    if params.on_stderr then
      params.on_stderr(text)
    end
  end)

  local close --[[@type fun(): dansa.kit.Async.AsyncTask]]
  local stdin = params.input and assert(vim.uv.new_pipe())
  local stdout = assert(vim.uv.new_pipe())
  local stderr = assert(vim.uv.new_pipe())
  local process = vim.uv.spawn(vim.fn.exepath(cmd), {
    cwd = vim.fs.normalize(params.cwd),
    env = env_pairs,
    gid = vim.uv.getgid(),
    uid = vim.uv.getuid(),
    hide = true,
    args = args,
    stdio = { stdin, stdout, stderr },
    detached = false,
    verbatim = false,
  } --[[@as any]], function(code, signal)
    stdout_buffer.close()
    stderr_buffer.close()
    close():next(function()
      if params.on_exit then
        params.on_exit(code, signal)
      end
    end)
  end)
  stdout:read_start(function(err, data)
    if err then
      error(err)
    end
    if data then
      stdout_buffer.write(data)
    end
  end)
  stderr:read_start(function(err, data)
    if err then
      error(err)
    end
    if data then
      stderr_buffer.write(data)
    end
  end)

  local stdin_closing = Async.new(function(resolve)
    if params.input and stdin then
      for _, input in ipairs(kit.to_array(params.input)) do
        stdin:write(input)
      end
      if stdin then
        stdin:close(resolve)
      end
    else
      resolve()
    end
  end)

  close = function()
    local closing = { stdin_closing }
    table.insert(closing, Async.new(function(resolve)
      if not stdout:is_closing() then
        stdout:close(resolve)
      else
        resolve()
      end
    end))
    table.insert(closing, Async.new(function(resolve)
      if not stderr:is_closing() then
        stderr:close(resolve)
      else
        resolve()
      end
    end))
    table.insert(closing, Async.new(function(resolve)
      if not process:is_closing() then
        process:close(resolve)
      else
        resolve()
      end
    end))
    return Async.all(closing)
  end

  return function(signal)
    if signal and process:is_active() and not process:is_closing() then
      process:kill(signal)
    end
    close()
  end
end

return System
