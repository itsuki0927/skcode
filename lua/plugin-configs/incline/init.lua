local helpers = require('incline.helpers')

require('incline').setup({
  window = {
    padding = 0,
    margin = { horizontal = 0 },
  },
  render = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
    local icon, color = require('nvim-web-devicons').get_icon_color(filename)

    local segments = {}

    table.insert(segments, { ' ' })
    if icon and #icon then
      table.insert(segments, { icon, guifg = color })
      table.insert(segments, { ' ' })
    end

    table.insert(segments, { filename })
    table.insert(segments, { ' ' })

    return segments
  end,

  -- render = function(props)
  --   local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
  --   local ft_icon, ft_color = require('nvim-web-devicons').get_icon_color(filename)
  --   local modified = vim.bo[props.buf].modified
  --   local buffer = {
  --     ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
  --     ' ',
  --     { filename, gui = modified and 'bold,italic' or 'bold' },
  --     ' ',
  --     guibg = '#44406e',
  --   }
  --   return buffer
  -- end,
})
