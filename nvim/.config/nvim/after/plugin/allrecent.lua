require('telescope-all-recent').setup({
  default = {
    disable = true,     -- disable any unkown pickers (recommended)
    use_cwd = true,     -- differentiate scoring for each picker based on cwd
    sorting = 'recent', -- sorting: options: 'recent' and 'frecency'
  },
})
