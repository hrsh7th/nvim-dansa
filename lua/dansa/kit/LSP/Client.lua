local LSP = require('dansa.kit.LSP')
local AsyncTask = require('dansa.kit.Async.AsyncTask')

---@class dansa.kit.LSP.Client
---@field public client vim.lsp.Client
local Client = {}
Client.__index = Client

---Create LSP Client wrapper.
---@param client vim.lsp.Client
---@return dansa.kit.LSP.Client
function Client.new(client)
  local self = setmetatable({}, Client)
  self.client = client
  return self
end

---Send request.
---@param method string
---@param params table
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:request(method, params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request(method, params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.ImplementationParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_implementation(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/implementation', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.TypeDefinitionParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_typeDefinition(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/typeDefinition', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params nil
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_workspaceFolders(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/workspaceFolders', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.ConfigurationParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_configuration(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/configuration', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.DocumentColorParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_documentColor(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/documentColor', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.ColorPresentationParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_colorPresentation(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/colorPresentation', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.FoldingRangeParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_foldingRange(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/foldingRange', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params nil
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_foldingRange_refresh(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/foldingRange/refresh', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.DeclarationParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_declaration(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/declaration', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.SelectionRangeParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_selectionRange(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/selectionRange', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.WorkDoneProgressCreateParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:window_workDoneProgress_create(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('window/workDoneProgress/create', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.CallHierarchyPrepareParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_prepareCallHierarchy(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/prepareCallHierarchy', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.CallHierarchyIncomingCallsParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:callHierarchy_incomingCalls(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('callHierarchy/incomingCalls', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.CallHierarchyOutgoingCallsParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:callHierarchy_outgoingCalls(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('callHierarchy/outgoingCalls', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.SemanticTokensParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_semanticTokens_full(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/semanticTokens/full', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.SemanticTokensDeltaParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_semanticTokens_full_delta(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/semanticTokens/full/delta', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.SemanticTokensRangeParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_semanticTokens_range(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/semanticTokens/range', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params nil
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_semanticTokens_refresh(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/semanticTokens/refresh', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.ShowDocumentParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:window_showDocument(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('window/showDocument', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.LinkedEditingRangeParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_linkedEditingRange(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/linkedEditingRange', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.CreateFilesParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_willCreateFiles(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/willCreateFiles', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.RenameFilesParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_willRenameFiles(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/willRenameFiles', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.DeleteFilesParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_willDeleteFiles(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/willDeleteFiles', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.MonikerParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_moniker(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/moniker', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.TypeHierarchyPrepareParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_prepareTypeHierarchy(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/prepareTypeHierarchy', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.TypeHierarchySupertypesParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:typeHierarchy_supertypes(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('typeHierarchy/supertypes', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.TypeHierarchySubtypesParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:typeHierarchy_subtypes(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('typeHierarchy/subtypes', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.InlineValueParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_inlineValue(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/inlineValue', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params nil
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_inlineValue_refresh(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/inlineValue/refresh', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.InlayHintParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_inlayHint(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/inlayHint', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.InlayHint
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:inlayHint_resolve(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('inlayHint/resolve', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params nil
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_inlayHint_refresh(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/inlayHint/refresh', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.DocumentDiagnosticParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_diagnostic(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/diagnostic', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.WorkspaceDiagnosticParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_diagnostic(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/diagnostic', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params nil
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_diagnostic_refresh(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/diagnostic/refresh', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.InlineCompletionParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_inlineCompletion(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/inlineCompletion', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.RegistrationParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:client_registerCapability(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('client/registerCapability', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.UnregistrationParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:client_unregisterCapability(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('client/unregisterCapability', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.InitializeParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:initialize(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('initialize', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params nil
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:shutdown(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('shutdown', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.ShowMessageRequestParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:window_showMessageRequest(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('window/showMessageRequest', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.WillSaveTextDocumentParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_willSaveWaitUntil(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/willSaveWaitUntil', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.CompletionParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_completion(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/completion', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.CompletionItem
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:completionItem_resolve(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('completionItem/resolve', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.HoverParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_hover(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/hover', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.SignatureHelpParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_signatureHelp(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/signatureHelp', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.DefinitionParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_definition(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/definition', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.ReferenceParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_references(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/references', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.DocumentHighlightParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_documentHighlight(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/documentHighlight', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.DocumentSymbolParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_documentSymbol(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/documentSymbol', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.CodeActionParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_codeAction(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/codeAction', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.CodeAction
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:codeAction_resolve(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('codeAction/resolve', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.WorkspaceSymbolParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_symbol(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/symbol', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.WorkspaceSymbol
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspaceSymbol_resolve(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspaceSymbol/resolve', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.CodeLensParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_codeLens(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/codeLens', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.CodeLens
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:codeLens_resolve(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('codeLens/resolve', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params nil
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_codeLens_refresh(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/codeLens/refresh', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.DocumentLinkParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_documentLink(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/documentLink', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.DocumentLink
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:documentLink_resolve(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('documentLink/resolve', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.DocumentFormattingParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_formatting(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/formatting', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.DocumentRangeFormattingParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_rangeFormatting(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/rangeFormatting', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.DocumentRangesFormattingParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_rangesFormatting(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/rangesFormatting', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.DocumentOnTypeFormattingParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_onTypeFormatting(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/onTypeFormatting', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.RenameParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_rename(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/rename', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.PrepareRenameParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:textDocument_prepareRename(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('textDocument/prepareRename', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.ExecuteCommandParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_executeCommand(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/executeCommand', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---@param params dansa.kit.LSP.ApplyWorkspaceEditParams
---@return dansa.kit.Async.AsyncTask|{cancel: fun()}
function Client:workspace_applyEdit(params)
  local that, _, request_id, reject_ = self, nil, nil, nil
  ---@type dansa.kit.Async.AsyncTask|{cancel: fun()}
  local task = AsyncTask.new(function(resolve, reject)
    reject_ = reject
    _, request_id = self.client:request('workspace/applyEdit', params, function(err, res)
      if err then
        reject(err)
      else
        resolve(res)
      end
    end)
  end)
  function task.cancel()
    that.client:cancel_request(request_id)
    reject_(LSP.ErrorCodes.RequestCancelled)
  end
  return task
end

---Send notification.
---@param method string
---@param params table
function Client:notify(method, params)
  self.client:notify(method, params)
end

---@param params dansa.kit.LSP.DidChangeWorkspaceFoldersParams
function Client:workspace_didChangeWorkspaceFolders(params)
  self.client:notify('workspace/didChangeWorkspaceFolders', params)
end

---@param params dansa.kit.LSP.WorkDoneProgressCancelParams
function Client:window_workDoneProgress_cancel(params)
  self.client:notify('window/workDoneProgress/cancel', params)
end

---@param params dansa.kit.LSP.CreateFilesParams
function Client:workspace_didCreateFiles(params)
  self.client:notify('workspace/didCreateFiles', params)
end

---@param params dansa.kit.LSP.RenameFilesParams
function Client:workspace_didRenameFiles(params)
  self.client:notify('workspace/didRenameFiles', params)
end

---@param params dansa.kit.LSP.DeleteFilesParams
function Client:workspace_didDeleteFiles(params)
  self.client:notify('workspace/didDeleteFiles', params)
end

---@param params dansa.kit.LSP.DidOpenNotebookDocumentParams
function Client:notebookDocument_didOpen(params)
  self.client:notify('notebookDocument/didOpen', params)
end

---@param params dansa.kit.LSP.DidChangeNotebookDocumentParams
function Client:notebookDocument_didChange(params)
  self.client:notify('notebookDocument/didChange', params)
end

---@param params dansa.kit.LSP.DidSaveNotebookDocumentParams
function Client:notebookDocument_didSave(params)
  self.client:notify('notebookDocument/didSave', params)
end

---@param params dansa.kit.LSP.DidCloseNotebookDocumentParams
function Client:notebookDocument_didClose(params)
  self.client:notify('notebookDocument/didClose', params)
end

---@param params dansa.kit.LSP.InitializedParams
function Client:initialized(params)
  self.client:notify('initialized', params)
end

---@param params nil
function Client:exit(params)
  self.client:notify('exit', params)
end

---@param params dansa.kit.LSP.DidChangeConfigurationParams
function Client:workspace_didChangeConfiguration(params)
  self.client:notify('workspace/didChangeConfiguration', params)
end

---@param params dansa.kit.LSP.ShowMessageParams
function Client:window_showMessage(params)
  self.client:notify('window/showMessage', params)
end

---@param params dansa.kit.LSP.LogMessageParams
function Client:window_logMessage(params)
  self.client:notify('window/logMessage', params)
end

---@param params dansa.kit.LSP.LSPAny
function Client:telemetry_event(params)
  self.client:notify('telemetry/event', params)
end

---@param params dansa.kit.LSP.DidOpenTextDocumentParams
function Client:textDocument_didOpen(params)
  self.client:notify('textDocument/didOpen', params)
end

---@param params dansa.kit.LSP.DidChangeTextDocumentParams
function Client:textDocument_didChange(params)
  self.client:notify('textDocument/didChange', params)
end

---@param params dansa.kit.LSP.DidCloseTextDocumentParams
function Client:textDocument_didClose(params)
  self.client:notify('textDocument/didClose', params)
end

---@param params dansa.kit.LSP.DidSaveTextDocumentParams
function Client:textDocument_didSave(params)
  self.client:notify('textDocument/didSave', params)
end

---@param params dansa.kit.LSP.WillSaveTextDocumentParams
function Client:textDocument_willSave(params)
  self.client:notify('textDocument/willSave', params)
end

---@param params dansa.kit.LSP.DidChangeWatchedFilesParams
function Client:workspace_didChangeWatchedFiles(params)
  self.client:notify('workspace/didChangeWatchedFiles', params)
end

---@param params dansa.kit.LSP.PublishDiagnosticsParams
function Client:textDocument_publishDiagnostics(params)
  self.client:notify('textDocument/publishDiagnostics', params)
end

---@param params dansa.kit.LSP.SetTraceParams
function Client:dollar_setTrace(params)
  self.client:notify('$/setTrace', params)
end

---@param params dansa.kit.LSP.LogTraceParams
function Client:dollar_logTrace(params)
  self.client:notify('$/logTrace', params)
end

---@param params dansa.kit.LSP.CancelParams
function Client:dollar_cancelRequest(params)
  self.client:notify('$/cancelRequest', params)
end

---@param params dansa.kit.LSP.ProgressParams
function Client:dollar_progress(params)
  self.client:notify('$/progress', params)
end

return Client
