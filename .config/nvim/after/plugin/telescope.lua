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
        },
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
	},
})

-- Remove dark background from Telescope borders
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })

nnoremap("<leader>af", ":Telescope find_files<CR>")
nnoremap("<leader>b", ":Telescope buffers<CR>")
nnoremap("<leader>s", ":Telescope tags<CR>")
nnoremap("<leader>t", ":Telescope git_files<CR>")
nnoremap("<leader>gg", function()
    require('telescope.builtin').live_grep()
end)
-- vim.keymap.set('n', "<leader>gs", function()
--     builtin.grep_string({ search = vim.fn.input("Rg > ") });
-- end)
nnoremap("<leader>k", function()
    require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>"), hidden = true }
end)
