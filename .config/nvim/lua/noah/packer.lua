return require("packer").startup(function()
  use("wbthomason/packer.nvim")

  use("vim-scripts/YankRing.vim")
  use("github/copilot.vim")

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    }
  }

  use("AndrewRadev/splitjoin.vim")
  -- use("AndrewRadev/ember_tools.vim")
  -- use("Raimondi/delimitMate")
  use("austintaylor/vim-indentobject")
  use("christoomey/vim-tmux-navigator") -- Seamless navigation between tmux panes and vim splits
  use("jgdavey/tslime.vim") -- send things to tmux
  -- use("dense-analysis/ale") -- linting
  use("itchyny/lightline.vim")
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }
  -- use("junegunn/fzf.vim") -- vim keybindings
  -- use("junegunn/fzf") -- vim keybindings
  -- use("junegunn/vim-easy-align") -- align tables in markdown
  use("morhetz/gruvbox") -- Different color scheme
  use("scrooloose/nerdtree") -- file system explorer
  -- use("sheerun/vim-polyglot") -- language packs
  use("thoughtbot/vim-rspec") -- rspec helper
  use("tpope/vim-abolish")
  use("tpope/vim-bundler")
  use("tpope/vim-commentary")
  use("tpope/vim-endwise")
  use("tpope/vim-eunuch")
  use("tpope/vim-fugitive")
  use("tpope/vim-projectionist") -- add .projectionist.json file for mapping heaven
  use("tpope/vim-rails")
  use("tpope/vim-rake")
  use("tpope/vim-rbenv")
  use("tpope/vim-repeat")
  use("tpope/vim-rhubarb")
  use("tpope/vim-surround")
  use("tpope/vim-unimpaired") -- Pairs of handy bracket mappings
  use("vim-ruby/vim-ruby")
  use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
  use("fatih/vim-go")
  use('theprimeagen/harpoon')
end)

