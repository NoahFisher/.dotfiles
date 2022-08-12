local Remap = require("noah.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap
local autocmd = vim.api.nvim_create_autocmd

nnoremap("<leader>pv", ":Ex<CR>")

inoremap("<C-c>", "<Esc>")

nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

nmap("<leader>a", ":Files<CR>")
nmap("<leader>b", ":Buffers<CR>")
nmap("<leader>s", ":Tags<CR>")
nmap("<leader>t", ":GFiles<CR>")

nnoremap("<leader>vv", ":Eview<CR>")
nnoremap("<leader>cc", ":Econtroller<CR>")

nmap("<leader>gg", ":Rg ")
vnoremap("<leader>k", ":Rg expand('<cword>')<CR>")

autocmd({"BufWritePre"}, {
        pattern = "*",
        command = "%s/\\s\\+$//e",
    })

autocmd('TextYankPost', {
        group = yank_group,
        pattern = '*',
        callback = function()
            vim.highlight.on_yank({
                    higroup = 'IncSearch',
                    timeout = 40,
                })
        end,
    })
