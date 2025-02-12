return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
    },
    opts = {
      servers = {
        lua_ls = {},
        tailwindcss = {},
        ts_ls = {},
        jsonls = {},
      },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. 'lsp')
      require('nvchad.lsp').diagnostic_config()

      -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      --   focusable = false,
      -- })

      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      local map = vim.keymap.set

      map('n', '<leader>rn', function()
        require('nvchad.lsp.renamer')()
      end)
      map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action)
      map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "single" })<CR>')
      map('n', ']d', '<cmd>lua vim.diagnostic.goto_prev({ border = "single" })<CR>')

      -- buf_map(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "single" })<CR>')
      -- buf_map(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "single" })<CR>')

      -- vim.api.nvim_create_autocmd('LspAttach', {
      --   callback = function(args)
      --     local client = vim.lsp.get_client_by_id(args.data.client_id)
      --
      --     if client.supports_method('textDocument/formatting') then
      --       vim.api.nvim_create_autocmd('BufWritePre', {
      --         buffer = args.buf,
      --         callback = function()
      --           vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
      --         end
      --       })
      --     end
      --   end
      -- })
    end,
  },
}
