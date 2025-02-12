return {
  {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
      local prettier = { 'prettierd', 'prettier', stop_after_first = true }

      require('conform').setup({
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'isort', 'black' },
          rust = { 'rustfmt', lsp_format = 'fallback' },
          javascript = prettier,
          typescript = prettier,
          javascriptreact = prettier,
          typescriptreact = prettier,
          markdown = prettier,
          json = prettier,
          jsonc = prettier,
          vue = prettier,
          css = prettier,
          less = prettier,
          scss = prettier,
          html = prettier,
        },
        formatters = {
          stylua = {
            args = {
              '--search-parent-directories',
              '--indent-type',
              'Spaces',
              '--stdin-filepath',
              '$FILENAME',
              '-',
            },
          },
        },
      })

      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        callback = function(args)
          require('conform').format({ bufnr = args.buf })
        end,
      })
    end,
  },
}
