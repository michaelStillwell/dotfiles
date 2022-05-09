return {
  map = function(mode, shortcut, command, options)
    local opts = options or {}
    vim.keymap.set(mode, shortcut, command, opts)
  end,
  nmap = function(mode, shortcut, command)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, shortcut, command, opts)
  end,
  is_available = function(plugin)
    local status_ok, plugin = pcall(require, plugin)
    return status_ok
  end
}
