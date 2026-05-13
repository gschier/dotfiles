return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#15130b',
				base01 = '#15130b',
				base02 = '#8d8b82',
				base03 = '#8d8b82',
				base04 = '#e3e1d6',
				base05 = '#fffdf8',
				base06 = '#fffdf8',
				base07 = '#fffdf8',
				base08 = '#ffa89f',
				base09 = '#ffa89f',
				base0A = '#eedd8b',
				base0B = '#b1ffa5',
				base0C = '#fff5c6',
				base0D = '#eedd8b',
				base0E = '#fff0a7',
				base0F = '#fff0a7',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#8d8b82',
				fg = '#fffdf8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#eedd8b',
				fg = '#15130b',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#8d8b82' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#fff5c6', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#fff0a7',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#eedd8b',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#eedd8b',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#fff5c6',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#b1ffa5',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#e3e1d6' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#e3e1d6' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#8d8b82',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
