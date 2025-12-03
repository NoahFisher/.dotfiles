-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  -- Copilot
  { "github/copilot.vim", event = "InsertEnter" },

  -- YankRing
  "vim-scripts/YankRing.vim",

  -- LSP Support
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
  },

  -- Utilities
  "AndrewRadev/splitjoin.vim",
  "austintaylor/vim-indentobject",
  { "christoomey/vim-tmux-navigator", lazy = false },
  "jgdavey/tslime.vim",
  { "itchyny/lightline.vim", lazy = false },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Set up keymaps here to ensure they're loaded
      local Remap = require("noah.keymap")
      local nnoremap = Remap.nnoremap

      nnoremap("<leader>af", ":Telescope find_files<CR>")
      nnoremap("<leader>b", ":Telescope buffers<CR>")
      nnoremap("<leader>s", ":Telescope tags<CR>")
      nnoremap("<leader>t", ":Telescope git_files<CR>")
      nnoremap("<leader>gg", function()
        require('telescope.builtin').live_grep()
      end)
      nnoremap("<leader>k", function()
        require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>"), hidden = true }
      end)
    end,
  },

  -- Vim plugins
  { "junegunn/vim-easy-align", cmd = "EasyAlign" },
  { "morhetz/gruvbox", lazy = false, priority = 1000 },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true,
        integrations = {
          telescope = true,
          harpoon = true,
          mason = true,
          native_lsp = {
            enabled = true,
          },
          treesitter = true,
        },
      })
    end,
  },
  { "scrooloose/nerdtree", cmd = { "NERDTree", "NERDTreeToggle", "NERDTreeFind" } },
  { "thoughtbot/vim-rspec", ft = "ruby" },
  "tpope/vim-abolish",
  { "tpope/vim-bundler", ft = "ruby" },
  "tpope/vim-commentary",
  { "tpope/vim-endwise", ft = "ruby" },
  "tpope/vim-eunuch",
  { "tpope/vim-fugitive", cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" } },
  { "tpope/vim-projectionist", ft = { "ruby", "javascript", "typescript" } },
  { "tpope/vim-rails", ft = "ruby" },
  { "tpope/vim-rake", ft = "ruby" },
  { "tpope/vim-rbenv", ft = "ruby" },
  "tpope/vim-repeat",
  "tpope/vim-rhubarb",
  "tpope/vim-surround",
  "tpope/vim-unimpaired",
  { "vim-ruby/vim-ruby", ft = "ruby" },

  -- TreeSitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },

  -- mini.icon
  {
    "echasnovski/mini.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('mini.icons').setup()
    end,
  },

  -- Markdown rendering
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      preset = 'lazy',
    },
  },

  -- Go support
  { "fatih/vim-go", ft = "go" },

  -- Harpoon
  {
    "theprimeagen/harpoon",
    lazy = false,
    config = function()
      local mark = require('harpoon.mark')
      local ui = require('harpoon.ui')

      vim.keymap.set("n", "<leader>h", mark.add_file)
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

      vim.keymap.set("n", "<C-7>", function() ui.nav_file(1) end)
      vim.keymap.set("n", "<C-8>", function() ui.nav_file(2) end)
      vim.keymap.set("n", "<C-9>", function() ui.nav_file(3) end)
      vim.keymap.set("n", "<C-0>", function() ui.nav_file(4) end)
    end,
  },

  -- Goyo
  { "junegunn/goyo.vim", cmd = "Goyo" },

  -- Image clipboard
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
}, {
  -- Lazy.nvim configuration options
  defaults = {
    lazy = false, -- plugins are not lazy-loaded by default
  },
  install = {
    colorscheme = { "gruvbox" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})