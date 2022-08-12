return require("packer").startup(function()
	use("wbthomason/packer.nvim")

	use("github/copilot.vim")
	use("neovim/nvim-lspconfig")
	use("AndrewRadev/ember_tools.vim")
	use("AndrewRadev/splitjoin.vim")
	use("Raimondi/delimitMate")
	use("austintaylor/vim-indentobject")
	use("christoomey/vim-tmux-navigator") -- Seamless navigation between tmux panes and vim splits
	use("dense-analysis/ale") -- linting
	use("itchyny/lightline.vim")
	use("jgdavey/tslime.vim") -- send things to tmux
	use("junegunn/fzf.vim") -- vim keybindings
	use("junegunn/fzf") -- vim keybindings
	use("junegunn/vim-easy-align") -- align tables in markdown
	use("morhetz/gruvbox") -- Different color scheme
	-- use("scrooloose/nerdtree") -- file system explorer
	use("sheerun/vim-polyglot") -- language packs
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
end)

