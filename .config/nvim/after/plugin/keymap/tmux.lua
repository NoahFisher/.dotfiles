local Remap = require("noah.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

vim.g.rspec_command = 'call Send_to_Tmux("CHROME_HEADLESS=true bin/rspec {spec}\n")'
vim.g.rspec_runner = "os_x_iterm2"

nnoremap("<leader>rs", ":call RunCurrentSpecFile()<CR>")
nnoremap("<leader>rl", ":call RunNearestSpec()<CR>")
nnoremap("<leader>rp", ":call RunLastSpec()<CR>")
nnoremap("<leader>ra", ":call RunAllSpecs()<CR>")
nnoremap("<leader>rr", "<Plug>SetTmuxVars")
vnoremap("<leader>rv", "<Plug>SendSelectionToTmux")
