local Remap = require("noah.keymap")
local nnoremap = Remap.nnoremap

require("telescope").setup({
	defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden"
        }
	},
})

nnoremap("<leader>a", ":Telescope find_files<CR>")
nnoremap("<leader>b", ":Telescope buffers<CR>")
nnoremap("<leader>s", ":Telescope tags<CR>")
nnoremap("<leader>t", ":Telescope git_files<CR>")
-- nnoremap("<leader>gg", ":Telescope grep_string<CR>")
nnoremap("<leader>gg", function()
    require('telescope.builtin').grep_string({ hidden=true })
end)
nnoremap("<leader>k", function()
    require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>"), hidden = true }
end)
-- nnoremap("<leader>a", function()
--     require('telescope.builtin').find_files({ hidden=true })
-- end)

