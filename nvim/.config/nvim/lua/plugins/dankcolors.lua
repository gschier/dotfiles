return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#0f1511',
				base01 = '#0f1511',
				base02 = '#808a83',
				base03 = '#808a83',
				base04 = '#d2dfd7',
				base05 = '#f8fffa',
				base06 = '#f8fffa',
				base07 = '#f8fffa',
				base08 = '#ffba9f',
				base09 = '#ffba9f',
				base0A = '#abeac3',
				base0B = '#a5ffa7',
				base0C = '#daffe8',
				base0D = '#abeac3',
				base0E = '#c6ffdb',
				base0F = '#c6ffdb',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#808a83',
				fg = '#f8fffa',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#abeac3',
				fg = '#0f1511',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#808a83' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#daffe8', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#c6ffdb',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#abeac3',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#abeac3',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#daffe8',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffa7',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#d2dfd7' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#d2dfd7' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#808a83',
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
