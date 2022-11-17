local Remap = require("noah.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap
local autocmd = vim.api.nvim_create_autocmd

nmap("sj", ":SplitjoinSplit<CR>")
nmap("sk", ":SplitjoinJoin<CR>")
nmap("<localleader>jt", "<Esc>:%!python3 -m json.tool<CR>")

nnoremap("<leader>pv", ":Ex<CR>")

inoremap("<C-c>", "<Esc>")

nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
nnoremap("<C-\\>", ":NERDTreeFind<CR>")

nnoremap("<leader>vv", ":Eview<CR>")
nnoremap("<leader>cc", ":Econtroller<CR>")

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
