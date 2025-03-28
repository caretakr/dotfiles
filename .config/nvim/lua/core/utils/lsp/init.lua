--
-- LSP functions
--

local M = {}

M.keymaps = require("core.utils.lsp.keymaps")

M._supports_method = {}

M.action = setmetatable({}, {
  __index = function(_, action)
    return function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { action },
          diagnostics = {},
        },
      })
    end
  end,
})

function M._check_methods(client, buffer)
  -- Don't trigger on invalid buffers
  if not vim.api.nvim_buf_is_valid(buffer) then
    return
  end

  -- Don't trigger on non-listed buffers
  if not vim.bo[buffer].buflisted then
    return
  end

  -- Don't trigger on nofile buffers
  if vim.bo[buffer].buftype == "nofile" then
    return
  end

  for method, clients in pairs(M._supports_method) do
    clients[client] = clients[client] or {}

    if not clients[client][buffer] then
      if client.supports_method and client.supports_method(method, { bufnr = buffer }) then
        clients[client][buffer] = true

        vim.api.nvim_exec_autocmds("User", {
          pattern = "LspSupportsMethod",
          data = { client_id = client.id, buffer = buffer, method = method },
        })
      end
    end
  end
end

function M.has_method(method, buffer)
  local utils = require("core.utils")

  if type(method) == "table" then
    for _, m in ipairs(method) do
      if M.has_method(m, buffer) then
        return true
      end
    end

    return false
  end

  method = method:find("/") and method or "textDocument/" .. method

  local clients = utils.lsp.get_clients({ bufnr = buffer })

  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end

  return false
end

function M.get_clients(opts)
  local ret = {}

  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    ---@diagnostic disable-next-line: deprecated
    ret = vim.lsp.get_active_clients(opts)
    if opts and opts.method then
      ret = vim.tbl_filter(function(client)
        return client.supports_method(opts.method, { bufnr = opts.bufnr })
      end, ret)
    end
  end

  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

function M.get_config(server)
  local ok, ret = pcall(require, "lspconfig.configs." .. server)

  if ok then
    return ret
  end

  return require("lspconfig.server_configurations." .. server)
end

function M.on_attach(on_attach, name)
  return vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local buffer = args.buf

      if client and (not name or client.name == name) then
        return on_attach(client, buffer)
      end
    end,
  })
end

function M.on_dynamic_capability(fn, opts)
  return vim.api.nvim_create_autocmd("User", {
    pattern = "LspDynamicCapability",
    group = opts and opts.group or nil,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local buffer = args.data.buffer

      if client then
        return fn(client, buffer)
      end
    end,
  })
end

function M.on_supports_method(method, fn)
  M._supports_method[method] = M._supports_method[method] or setmetatable({}, { __mode = "k" })

  return vim.api.nvim_create_autocmd("User", {
    pattern = "LspSupportsMethod",
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local buffer = args.data.buffer

      if client and method == args.data.method then
        return fn(client, buffer)
      end
    end,
  })
end

function M.execute(opts)
  local params = {
    command = opts.command,
    arguments = opts.arguments,
  }

  if opts.open then
    require("trouble").open({
      mode = "lsp_command",
      params = params,
    })
  else
    return vim.lsp.buf_request(0, "workspace/executeCommand", params, opts.handler)
  end
end

function M.setup()
  local register_capability = vim.lsp.handlers["client/registerCapability"]

  vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
    local ret = register_capability(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)

    if client then
      for buffer in pairs(client.attached_buffers) do
        vim.api.nvim_exec_autocmds("User", {
          pattern = "LspDynamicCapability",
          data = { client_id = client.id, buffer = buffer },
        })
      end
    end

    return ret
  end

  M.on_attach(M._check_methods)
  M.on_dynamic_capability(M._check_methods)
end

return M
