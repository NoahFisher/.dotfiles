vim.g.copilot_node_command = '/Users/noah/.nvm/versions/node/v20.17.0/bin/node'

vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
