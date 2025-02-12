---@type LazySpec
return {
  'akinsho/nvim-toggleterm.lua',
  version = '*',
  keys = { '<leader>tg', '<C-\\>' },
  opts = {
    size = 100,
    shell = vim.o.shell == '/bin/fish' and '/bin/zsh' or vim.o.shell,
    direction = 'float',
    open_mapping = [[<c-\>]],
    highlights = { FloatBorder = { link = 'FloatBorder' } },
    float_opts = { border = 'single' },
  },
  config = function(_, opts)
    local Terminal = require('toggleterm.terminal').Terminal
    local toggleterm = require('toggleterm')
    local lazygit = Terminal:new({
      cmd = 'lazygit',
      dir = 'git_dir',
      direction = 'float',
      float_opts = { border = 'single' },
      size = 100,
    })

    local function lazygit_toggle()
      lazygit:toggle()
    end

    toggleterm.setup(opts)
    vim.keymap.set('n', '<leader>tg', lazygit_toggle, { desc = '[T]erminal [L]azygit' })
  end,
}
