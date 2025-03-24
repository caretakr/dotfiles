--
-- Keymaps functions
--

local M = {}

function M._resolve(spec, buffer)
  local Keys = require("lazy.core.handler.keys")
  local utils = require("core.utils")

  if not Keys.resolve then
    return {}
  end

  local opts = utils.get_opts("nvim-lspconfig")
  local clients = utils.lsp.get_clients({ bufnr = buffer })

  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}

    vim.list_extend(spec, maps)
  end

  return Keys.resolve(spec)
end

function M.on_attach(spec, _, buffer)
  local Keys = require("lazy.core.handler.keys")
  local utils = require("core.utils")

  local keymaps = M._resolve(spec, buffer)

  for _, keys in pairs(keymaps) do
    local has = not keys.has or utils.lsp.has_method(keys.has, buffer)
    local cond = not (keys.cond == false or ((type(keys.cond) == "function") and not keys.cond()))

    if has and cond then
      local opts = Keys.opts(keys)

      opts.cond = nil
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer

      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
