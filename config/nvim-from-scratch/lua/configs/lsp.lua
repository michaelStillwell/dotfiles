-- TODO: flush this out, just do lua first and get that working

local border = {
  {'🭽', 'FloatBorder'},
  {'▔', 'FloatBorder'},
  {'🭾', 'FloatBorder'},
  {'▕', 'FloatBorder'},
  {'🭿', 'FloatBorder'},
  {'▁', 'FloatBorder'},
  {'🭼', 'FloatBorder'},
  {'▏', 'FloatBorder'},
}

local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = border}),
}

local icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = "了 ",
  EnumMember = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = "ƒ ",
  Module = " ",
  Property = " ",
  Snippet = "﬌ ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

local function setup()
  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = icons[kind] or kind
  end
end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false
})

-- require'lspconfig'.myserver.setup {handlers=handlers}
local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
  return
end

lsp_installer.settings({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})


lsp_installer.on_server_ready(function(server)
  local opts = {}

  opts.on_attach = handlers
  opts.capabilities = capabilities

  local exists, settings = pcall(require, 'configs.server-settings.' .. server.name)
  if exists then
    opts = vim.tbl_deep_extend('force', settings, opts)
  end

  server:setup(opts)
end)
