local default_treesitter_config = skcode.load_config().plugins.options.treesitter

local present, treesitter = pcall(require, 'nvim-treesitter.configs')

local swap_next, swap_prev = (function()
  local swap_objects = {
    p = '@parameter.inner',
    f = '@function.outer',
    e = '@element',
  }

  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format('<leader>s%s', key)] = obj
    p[string.format('<leader>s%s', string.upper(key))] = obj
  end

  return n, p
end)()

if present then
  require('base46').load_highlight('treesitter')
  treesitter.setup({
    ensure_installed = default_treesitter_config.ensure_installed,
    sync_install = false,
    ignore_install = { 'help' },
    highlight = {
      enable = true,
      disable = { '' },
      additional_vim_regex_highlighting = true,
    },
    autotag = {
      enable = true,
    },
    indent = { enable = true, disable = { 'yaml' } },
    autopairs = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<CR>',
        node_incremental = '<CR>',
        scope_incremental = '<S-CR>',
        node_decremental = '<BS>',
      },
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
      config = {
        c = '// %s',
        lua = '-- %s',
      },
    },
    textobjects = {
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']a'] = '@parameter.inner',

          [']m'] = '@function.outer',
          [']p'] = { query = '@class.outer', desc = 'Next class start' },
          --
          -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
          [']o'] = '@loop.*',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[a'] = '@parameter.inner',
          ['[m'] = '@function.outer',
          ['[p'] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
        goto_next = {
          [']i'] = '@conditional.outer',
        },
        goto_previous = {
          ['[i'] = '@conditional.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>na'] = '@parameter.inner',
          ['<leader>nm'] = '@function.outer',
        },
        swap_previous = {
          ['<leader>pa'] = '@parameter.inner',
          ['<leader>pm'] = '@function.outer',
        },
      },
    },
  })
end
