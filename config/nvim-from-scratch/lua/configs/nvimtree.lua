-- Nvimtree config
-- =======================

vim.g.nm_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "",
        staged = "S",
        unmerged = "",
        renamed = "➜",
        deleted = "",
        untracked = "U",
        ignored = "◌",
    },
    folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
    },
}

local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
    return
end

local status_ok, _ = pcall(require, 'nvim-tree.config')
if not status_ok then
    return
end

nvim_tree.setup {
    open_on_tab = true,
    actions = {
        open_file = {
            resize_window = true
        }
    }
}
