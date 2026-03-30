vim.lsp.config('luals', {
  cmd = {'lua-language-server'},
  filetypes = {'lua'},
  root_markers = {'.luarc.json', '.luarc.jsonc'},
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Rust (defaults)
vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
  capabilities = capabilities,
})

-- Go (gopls)
vim.lsp.config('gopls', {
  cmd = { 'gopls' },                                  -- Mason puts this on PATH
  filetypes = { 'go', 'gomod', 'gowork' },
  root_markers = { 'go.work', 'go.mod', '.git' },

  capabilities = capabilities,
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      analyses = {
        unusedparams = true,
        nilness = true,
        unusedwrite = true,
        shadow = true,
      },
    },
  },
})

vim.lsp.config('tailwindcss', {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = {
    'astro',
    'css',
    'eruby',
    'gohtml',
    'gohtmltmpl',
    'heex',
    'html',
    'htmlangular',
    'javascript',
    'javascriptreact',
    'svelte',
    'templ',
    'typescript',
    'typescriptreact',
    'vue',
  },
  root_markers = {
    'tailwind.config.js',
    'tailwind.config.cjs',
    'tailwind.config.mjs',
    'tailwind.config.ts',
    'postcss.config.js',
    'postcss.config.cjs',
    'postcss.config.mjs',
    'postcss.config.ts',
    'package.json',
    '.git',
  },
  capabilities = capabilities,
})

vim.lsp.enable({'luals', 'rust_analyzer', 'gopls', 'tailwindcss'})

vim.keymap.set('n', '<C-j>', '<cmd>lua vim.lsp.buf.hover()<cr>', {})
vim.keymap.set('', '<F6>', '<cmd>lua vim.lsp.buf.rename()<cr>', {})
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<cr>', {})
vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', {})
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', {})

-- Errors
vim.keymap.set('n', '<leader>e', vim.diagnostic.goto_next, {})
vim.keymap.set('n', '<leader>E', vim.diagnostic.goto_prev, {})
