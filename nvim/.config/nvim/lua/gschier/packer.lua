vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim" })

	use({ "0x00-ketsu/autosave.nvim", as = "autosave" })
	use({ "AndrewRadev/tagalong.vim", as = "tagalong" })
	use({ "NvChad/nvim-colorizer.lua", as = "colorizer" })
	use({ "RRethy/vim-illuminate", as = "illuminate" })
	use({ "akinsho/toggleterm.nvim", as = "toggleterm" })
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "folke/trouble.nvim", requires = { "nvim-tree/nvim-web-devicons" } })
	use({ "github/copilot.vim", as = "copilot" })
	use({ "kevinhwang91/nvim-ufo", requires = { "kevinhwang91/promise-async" } })
	use({ "lewis6991/gitsigns.nvim", as = "gitsigns" })
	use({ "lukas-reineke/indent-blankline.nvim", as = "indent-blankline" })
	use({ "luukvbaal/statuscol.nvim" })
	use({ "numToStr/Comment.nvim", as = "comment" })
	use({ "nvim-lualine/lualine.nvim", requires = { "nvim-tree/nvim-web-devicons" } })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.8", requires = { "nvim-lua/plenary.nvim" } })
	use({ "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" } })
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "petertriho/nvim-scrollbar", as = "scrollbar" })
	use({ "prochri/telescope-all-recent.nvim", requires = { { "kkharji/sqlite.lua" } } })
	use({ "rcarriga/nvim-notify", as = "notify" })
	use({ "rmagatti/auto-session", as = "autosession" })
	use({ "sbdchd/neoformat" })
	use({ "stevearc/dressing.nvim", as = "dressing" })
	use({ "tpope/vim-fugitive", as = "fugitive" })
	use({ "tpope/vim-sleuth", as = "sleuth" })
	use({ "windwp/nvim-autopairs", as = "autopairs" })

	-- Formatter
	use({ "stevearc/conform.nvim", as = "conform" })

	-- Languages
	use({ "ray-x/go.nvim", as = "go", requires = { "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter" } })
	use({ "pmizio/typescript-tools.nvim", requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } })
	use({
		"luckasRanarison/tailwind-tools.nvim",
		as = "tailwind-tools",
		requires = { "nvim-treesitter/nvim-treesitter", "nvim-telescope/telescope.nvim", "neovim/nvim-lspconfig" },
	})

	-- Autocompletion
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "L3MON4D3/LuaSnip" })

	-- Cmp icons
	use({ "onsails/lspkind.nvim" })

	-- Themes
	use({
		"loctvl842/monokai-pro.nvim",
		config = function()
			require("monokai-pro").setup()
		end,
	})
end)
