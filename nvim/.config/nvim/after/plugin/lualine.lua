require('lualine').setup({
  extensions = { 'toggleterm', 'nvim-tree', 'overseer' },
  options = {
    icons_enabled = false,
    theme = 'auto',
    section_separators = { left = '', right = '' },
    component_separators = { left = '|', right = '|' },
  },
  ignore_focus = "NvimTree",
  sections = {
    lualine_a = {
      { 'filename', separator = { left = '', right = '' } },
    },
    lualine_b = { 
      {'branch', padding = { left = 2, right = 1 }},
      'diff',
      'diagnostics',
    },
    lualine_c = { 'overseer' },
    lualine_x = {},
    lualine_y = {
       { 'filetype', padding = { left = 1, right = 2 } },
    },
    lualine_z = {
      'progress',
      { 'location', separator = { right = '' } },
    }
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
})
