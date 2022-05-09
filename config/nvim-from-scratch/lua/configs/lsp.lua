local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
  return
end

local on_attach = function(_, _) -- bufnr)
  --local opts = { buffer = bufnr }
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require('cmp_nvim_lsp').update_capabilities(capabilites)

lsp_installer.on_server_ready(function(server)
  local opts = {}
  opts.on_attach = on_attach
  opts.capabilities = capabilities

  local exists, config = pcall(require, 'configs.lsp-servers.' .. server.name)
  if exists then
    opts = vim.tbl_deep_extend('force', config, opts)
  end

  server:setup(opts)
end)
