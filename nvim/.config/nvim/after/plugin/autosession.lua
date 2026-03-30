require('auto-session').setup({
  -- Clear jumps on restore
  post_restore_cmds = { 'clearjumps' },
  -- Close nvim-tree on save
  pre_save_cmds = { 'NvimTreeClose' },
})
