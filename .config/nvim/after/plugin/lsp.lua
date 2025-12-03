local function lsp_setup()
  -- Set up completion
  local cmp = require('cmp')
  local cmp_select = { behavior = cmp.SelectBehavior.Select }

  cmp.setup({
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
      ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
      ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
      ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
      ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-Space>'] = cmp.mapping.complete(),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    })
  })

  -- LSP attach function
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local bufnr = args.buf
      local opts = { buffer = bufnr, remap = false }

      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
      vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
      vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
      vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
      vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
      vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
      vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
      vim.keymap.set("i", "<leader>h", function() vim.lsp.buf.signature_help() end, opts)
    end
  })

  -- Set up language servers using vim.lsp.config (for nvim 0.11+)
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- ESLint
  vim.lsp.config.eslint = {
    cmd = { 'vscode-eslint-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    capabilities = capabilities,
    root_dir = function(fname)
      return vim.fs.root(fname, { '.eslintrc.js', '.eslintrc.json', '.eslintrc', 'package.json' })
    end,
  }

  -- Rust Analyzer
  vim.lsp.config.rust_analyzer = {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    capabilities = capabilities,
  }

  -- Lua LSP
  vim.lsp.config.lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }

  -- Ember Language Server
  vim.lsp.config.ember = {
    cmd = { 'ember-language-server', '--stdio' },
    filetypes = { 'handlebars', 'typescript', 'javascript' },
    capabilities = capabilities,
    root_dir = function(fname)
      return vim.fs.root(fname, { 'ember-cli-build.js', '.ember-cli', 'package.json' })
    end,
  }

  -- Go Language Server (gopls)
  vim.lsp.config.gopls = {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    capabilities = capabilities,
    root_dir = function(fname)
      return vim.fs.root(fname, { 'go.mod', 'go.work', '.git' })
    end,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = true,
      },
    },
  }

  -- Enable LSP for these filetypes
  vim.lsp.enable('eslint')
  vim.lsp.enable('rust_analyzer')
  vim.lsp.enable('lua_ls')
  vim.lsp.enable('ember')
  vim.lsp.enable('gopls')

  -- Explicitly start gopls for Go files (fallback if vim.lsp.enable doesn't work)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'go', 'gomod', 'gowork', 'gotmpl' },
    callback = function()
      vim.lsp.start({
        name = 'gopls',
        cmd = { 'gopls' },
        root_dir = vim.fs.root(0, { 'go.mod', 'go.work', '.git' }),
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })
    end,
  })
end

lsp_setup()
