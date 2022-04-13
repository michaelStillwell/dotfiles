return {
	map = function(mode, shortcut, command, options)
		local opts = options or {}
		vim.api.nvim_set_keymap(mode, shortcut, command, opts)
	end,
	
	nmap = function(mode, shortcut, command)
		local opts = { noremap = true, silent = true }
		vim.api.nvim_set_keymap(mode, shortcut, command, opts)
	end
}

