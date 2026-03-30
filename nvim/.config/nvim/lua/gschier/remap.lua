--------------------
-- Colemak Remaps --

-- Core motions
vim.api.nvim_set_keymap("", "e", "k", { noremap = true }); -- up
vim.api.nvim_set_keymap("", "n", "j", { noremap = true }); -- down
vim.api.nvim_set_keymap("", "i", "l", { noremap = true }); -- right (note, left is same in QWERTY)

-- Other things
vim.api.nvim_set_keymap("v", "l", "i", { noremap = true }); -- For `viw` and similar
vim.api.nvim_set_keymap("", "s", "i", { noremap = true }); -- For insert
vim.api.nvim_set_keymap("", "j", "n", { noremap = true }); -- For search next
vim.api.nvim_set_keymap("", "J", "N", { noremap = true }); -- For search pr
vim.api.nvim_set_keymap("", "k", "e", { noremap = true }); -- ?
vim.api.nvim_set_keymap("", "N", "J", { noremap = true }); -- For joining lines

------------------
-- Other Remaps --

-- Swap scroll screen keys
vim.api.nvim_set_keymap("n", "<C-n>", "<C-y>", {});
vim.api.nvim_set_keymap("n", "<C-e>", "<C-e>", {});

-- Disable recording feature
vim.api.nvim_set_keymap("n", "q", "<noop>", {});

-- Splits
vim.api.nvim_set_keymap("", "<C-w>h", ":wincmd h<CR>", {})
vim.api.nvim_set_keymap("", "<C-w>n", ":wincmd j<CR>", {})
vim.api.nvim_set_keymap("", "<C-w>e", ":wincmd k<CR>", {})
vim.api.nvim_set_keymap("", "<C-w>i", ":wincmd l<CR>", {})
