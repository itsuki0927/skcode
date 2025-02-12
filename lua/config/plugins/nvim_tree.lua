-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

return {
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = function()
      dofile(vim.g.base46_cache .. 'nvimtree')
      local api = require('nvim-tree.api')

      local function on_attach(bufnr)
        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        -- 使用默认的mapping
        api.config.mappings.default_on_attach(bufnr)

        -- 添加自定义的mapping
        vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
        vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
        vim.keymap.set('n', 'V', api.node.open.horizontal, opts('Open: Horizontal Split'))
      end

      require('nvim-tree').setup({
        filters = { dotfiles = false },
        disable_netrw = true,
        -- disabled_filetypes = { "packer", "NvimTree" },
        hijack_cursor = true,
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        on_attach = on_attach,
        view = {
          width = 30,
          preserve_window_proportions = true,
        },
        renderer = {
          root_folder_label = false,
          highlight_git = true,
          indent_markers = { enable = true },
          icons = {
            glyphs = {
              default = '󰈚',
              folder = {
                default = '',
                empty = '',
                empty_open = '',
                open = '',
                symlink = '',
              },
              git = { unmerged = '' },
            },
          },
        },
      })
    end,
  },
}
