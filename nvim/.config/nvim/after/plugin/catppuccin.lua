require('catppuccin').setup({
  term_colors = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    lsp_trouble = false,
    telescope = true,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
  },
});

vim.cmd('colorscheme catppuccin')
