local opts = {
  settings = {
    ['rust-analyzer'] = {
      cargo = {
      },
      checkOnSave = {
        command = 'clippy',
      },
      experimental = {
        procAttrMacros = true,
      },
    },
  }
}

return opts
