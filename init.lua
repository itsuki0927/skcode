require('core.global')
require('core.utils')
require('core.options')
require('core.autocmds')
require('core.mappings').init()
require('core.plugin')
require('core.plugin.list')

vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>')
