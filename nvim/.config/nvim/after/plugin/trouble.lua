local trouble = require('trouble');
trouble.setup({
  mode = 'document_diagnostics',
  action_keys = {
    open_split = {},
    open_vsplit = {},
  }
})

vim.keymap.set("n", "<C-x>", function() trouble.toggle() end)
vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end)
vim.keymap.set("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end)
