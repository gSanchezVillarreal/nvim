-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'ibhagwan/fzf-lua',
	  -- optional for icon support
	  requires = { 'nvim-tree/nvim-web-devicons' }
  }

  
  use { "ellisonleao/gruvbox.nvim" }
  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = ':TSUpdate'
  }
  use {'nvim-lua/plenary.nvim'}
  use {'theprimeagen/harpoon'}
  use {'mbbill/undotree'}
  use {'tpope/vim-fugitive'}
  use {'nvim-tree/nvim-tree.lua'}
  use {'machakann/vim-sandwich'}
  use {'windwp/nvim-autopairs'}
  use {'nvim-lualine/lualine.nvim'}
  use {'L3MON4D3/LuaSnip'}
  use {'saadparwaiz1/cmp_luasnip'}
  use {'rafamadriz/friendly-snippets'}
  use {'wakatime/vim-wakatime'}
  use {'simrat39/rust-tools.nvim'}
  use {'github/copilot.vim'}
  use {'windwp/nvim-ts-autotag'}
--lsp
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v2.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {                                      -- Optional
		  'williamboman/mason.nvim',
		  run = function()
			  pcall(vim.cmd, 'MasonUpdate')
		  end,
	  },
	  {'williamboman/mason-lspconfig.nvim'}, -- Optional

	  -- Autocompletion
	  {'hrsh7th/nvim-cmp'},     -- Required
	  {'hrsh7th/cmp-nvim-lsp'}, -- Required
	  {'L3MON4D3/LuaSnip'},     -- Required
  		}
	}
end)
