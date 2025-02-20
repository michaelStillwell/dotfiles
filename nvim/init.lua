vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)


-- [[ Plugins ]]
require('lazy').setup({

	-- color scheme yo
	{ 'ellisonleao/gruvbox.nvim' },
	-- #harpoon mentioned
	{ 'ThePrimeagen/harpoon',    branch = 'harpoon2', dependencies = 'nvim-lua/plenary.nvim' },

	-- treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
			'nushell/tree-sitter-nu',
		},
		build = ':TSUpdate',
	},
	{ 'nvim-treesitter/nvim-treesitter-context' },

	-- lsp
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			{ 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
			'folke/neodev.nvim',
		}
	},

	-- autocompletion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- snippet engine
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lsp',
			'rafamadriz/friendly-snippets',
		}
	},

	-- git
	{ 'tpope/vim-fugitive' },
	{ 'tpope/vim-rhubarb' },
	{
		-- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				theme = 'gruvbox',
				component_separators = '|',
				section_separators = '',
			},
		},
	},

	-- lualine
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
					{ buffer = bufnr, desc = 'Preview git hunk' })

				-- don't override the built-in and fugitive keymaps
				local gs = package.loaded.gitsigns
				vim.keymap.set({ 'n', 'v' }, ']c', function()
					if vim.wo.diff then
						return ']c'
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return '<Ignore>'
				end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
				vim.keymap.set({ 'n', 'v' }, '[c', function()
					if vim.wo.diff then
						return '[c'
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return '<Ignore>'
				end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
			end,
		},
	},

	-- fuzzy find
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
		},
	},

	-- tabnine
	{ 'codota/tabnine-nvim',  build = "./dl_binaries.sh" },
	-- comment
	{ 'numToStr/Comment.nvim' },


	-- godot
	{ 'habamax/vim-godot' },


	-- zen
	{ "folke/zen-mode.nvim" },

	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>p",
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				-- NOTE: this requires a version of yazi that includes
				-- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
				'<c-up>',
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = true,
			keymaps = {
				show_help = '<f1>',
			},
		},
	}
})

-- [[ Settings ]]


-- transparent background because weeb
vim.cmd("let g:gruvbox_transparent_bg = 1")
vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
vim.cmd("colorscheme gruvbox")


vim.o.hlsearch = false
vim.wo.number = true
vim.wo.relativenumber = true

vim.o.mouse = 'a'

vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- TODO: look into this and make a decision
vim.o.clipboard = 'unnamedplus'

vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = 'yes'

vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- TODO: research this
vim.completeopt = 'menuone,noselect'

vim.o.scrolloff = 10
vim.o.wrap = false
vim.opt.colorcolumn = '100'


-- [[ Keymaps ]]

-- better default experience (idk)
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })


-- explorer
-- vim.keymap.set('n', '<leader>p', vim.cmd.Ex, { desc = 'Open Explorer' })

-- formatting
vim.keymap.set('n', '<leader>f', function()
	vim.lsp.buf.format()
end)

-- add execute to file
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- scrolling
vim.keymap.set('n', '<C-i>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- zellij sessionizer
-- TODO: uncommnet this when done with the plugin
vim.keymap.set('n', '<C-z>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

-- zen mode
vim.keymap.set('n', '<leader>z', function() require('zen-mode').toggle() end)

-- [[ Harpoon ]]
local harpoon = require('harpoon')
harpoon:setup({})

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set('n', '<C-a>', function() harpoon:list():select(1) end)
vim.keymap.set('n', '<C-s>', function() harpoon:list():select(2) end)
vim.keymap.set('n', '<C-d>', function() harpoon:list():select(3) end)
vim.keymap.set('n', '<C-f>', function() harpoon:list():select(4) end)


-- [[ Highlight on Yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*'
})


-- [[ Fugitive ]]
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

-- ripped from prime's dotfiles
local fugitive_group = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})
local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
	group = fugitive_group,
	pattern = "*",
	callback = function()
		if vim.bo.ft ~= "fugitive" then
			return
		end

		local bufnr = vim.api.nvim_get_current_buf()
		local opts = { buffer = bufnr, remap = false }
		vim.keymap.set("n", "<leader>p", function()
			vim.cmd.Git('push')
		end, opts)

		-- rebase always
		vim.keymap.set("n", "<leader>P", function()
			vim.cmd.Git({ 'pull', '--rebase' })
		end, opts)

		-- NOTE: It allows me to easily set the branch i am pushing and any tracking
		-- needed if i did not set the branch up correctly
		vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
	end,
})


-- [[ Telescope ]]
require('telescope').setup({
	defaults = {
		mappings = {
			i = {
				['<C-u>'] = false,
				['<C-d>'] = false,
			}
		}
	},
	pickers = {
		git_files = { theme = "ivy" },
		find_files = { theme = "ivy" },
		help_tags = { theme = "ivy" },
		grep_string = { theme = "ivy" },
		live_grep = { theme = "ivy" },
		diagnostics = { theme = "ivy" },
		lsp_definitions = { theme = "ivy" },
		lsp_references = { theme = "ivy" },
		lsp_implementations = { theme = "ivy" },
		lsp_type_definitions = { theme = "ivy" },
		lsp_document_symbols = { theme = "ivy" },
		lsp_dynamic_workspace_symbols = { theme = "ivy" },
	}
})
pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><Space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Find in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Seach [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })


-- [[ Treesitter ]]
vim.defer_fn(function()
	require('nvim-treesitter.configs').setup({
		modules = {},
		sync_install = false,
		ignore_install = {},

		ensure_installed = { 'lua', 'rust', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },
		auto_install = false,

		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				-- init_selection    = '<C-Space>',
				-- node_incremental  = '<C-Space>',
				-- scope_incremental = '<C-Space>',
				-- node_decremental  = '<C-Space>',
			}
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					['aa'] = '@parameter.outer',
					['ia'] = '@parameter.inner',
					['af'] = '@function.outer',
					['if'] = '@function.outer',
					['ac'] = '@class.outer',
					['ic'] = '@class.outer',
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					[']m'] = '@function.outer',
					[']]'] = '@class.outer',
				},
				goto_next_end = {
					[']M'] = '@function.outer',
					[']['] = '@class.outer',
				},
				goto_previous_start = {
					['[m'] = '@function.outer',
					['[['] = '@class.outer',
				},
				goto_previous_end = {
					['[M'] = '@function.outer',
					['[]'] = '@class.outer',
				},
			},
			swap = {
				enable = true,
				swap_next = {
					['<leader>sp'] = '@parameter.inner',
				},
				swap_previous = {
					['<leader>sP'] = '@parameter.inner',
				},
			},
		},
	})
end, 0)

require('treesitter-context').setup({
	max_lines = 1
})


-- [[ Diagnostics ]]
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic list' })


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pws', function()
	local word = vim.fn.expand("<cword>")
	builtin.grep_string({ search = word })
end)
vim.keymap.set('n', '<leader>pWs', function()
	local word = vim.fn.expand("<cWORD>")
	builtin.grep_string({ search = word })
end)

-- [[ Lsp ]]
local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	-- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
	nmap('<C-c>', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinitions')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

	local a = ""
	print(a)

	nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementations')
	nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinitions')
	nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<C-K>', vim.lsp.buf.signature_help, 'Signature Documentation')

	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	nmap('<leader>wl', function()
		print(vim.lsp.buf.list_workspace_folders())
	end, '[W]orkspace [L]ist Folders')

	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end


-- [[ Mason ]]
require('mason').setup()
require('mason-lspconfig').setup()

local servers = {
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		}
	}
}


-- [[ Neodev ]]
require('neodev').setup()


-- [[ Completions ]]
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require('lspconfig')[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end
})

-- [[ Godot ]]
require('lspconfig').gdscript.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {},
	filetypes = ({}).filetypes,
})

-- [[ Gleam ]]
require('lspconfig').gleam.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {},
	filetypes = ({}).filetypes,
})


-- NOTE: this is the settings for using on windows if i care enough
-- force_setup = true, -- because the LSP is global. Read more on lsp-zero docs about this.
-- single_file_support = false,
-- cmd = {'ncat', '127.0.0.1', '6008'}, -- the important trick for Windows!
-- root_dir = require('lspconfig.util').root_pattern('project.godot', '.git'),
-- filetypes = {'gd', 'gdscript', 'gdscript3' }

-- [[ lualine ]]
require('lualine').setup({
	options = {
		theme = 'gruvbox',
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'diagnostics' },
		lualine_x = { 'tabnine' },
		lualine_c = {
			{
				'filename',
				path = 1
			}
		},
	},
})


-- [[ tabnine ]]
require('tabnine').setup({
	disable_auto_comment = false,
	accept_keymap = "<C-Right>",
	dismiss_keymap = "<C-Left>",
	debounce_ms = 800,
	suggestion_color = { gui = "#808080", cterm = 244 },
	exclude_filetypes = { "TelescopePrompt", "NvimTree" },
	log_file_path = nil,
})

-- [[ nvim-cmp ]]
local cmp = require('cmp')

-- [[ luasnip ]]
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup({})

local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
luasnip.add_snippets("all", {
	s("enn", {
		t({ "if err != nil {", "\t" }),
		i(1, ""),
		t({ "", "}" })
	})
})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete({}),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	}),
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
})

-- [[ comment ]]
require('Comment').setup({
	toggler = {
		line = 'gcm',
		block = 'gcn',
	},
	ignore = '^$',
})
