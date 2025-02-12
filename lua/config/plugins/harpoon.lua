return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup({})

      local map = vim.keymap.set

      map('n', '<leader>a', function()
        harpoon:list():add()
      end)
      map('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      map('n', '<C-f>', function()
        harpoon:list():select(1)
      end)
      map('n', '<C-p>', function()
        harpoon:list():select(2)
      end)
      map('n', '<C-y>', function()
        harpoon:list():select(3)
      end)
      map('n', '<C-t>', function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      map('n', '<C-S-P>', function()
        harpoon:list():prev()
      end)
      map('n', '<C-S-N>', function()
        harpoon:list():next()
      end)
    end,
  },
}
