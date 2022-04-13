
-- Plugins - Packer
-- ======================================
-- ======================================
local install_path = vim.fn.stdpath 'data' ..
    '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    }
    print '[Installing] packer.nvim'
    vim.cmd [[packadd packer.nvim]]
end

-- Packer
-- Verify install
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Packer config
packer.init {
    display = {
        -- Packer Module
        open_fn = function()
            return require('packer.util').float { border = 'rounded' }
        end
    },
    -- default_url_format = 'git@github.com:%s'
}


-- Packages
return packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'ellisonleao/gruvbox.nvim'

    -- Treesitter
    use 'nvim-treesitter/nvim-treesitter'

    -- Nvim-Tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
        config = function() require'nvim-tree'.setup {} end
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
end)
