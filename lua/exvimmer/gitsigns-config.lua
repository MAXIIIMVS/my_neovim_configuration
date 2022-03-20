require('gitsigns').setup{
  attach_to_untracked = true,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
    delay = 0,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author> <author_mail>: <summary>',
}

vim.cmd('highlight GitSignsCurrentLineBlame guifg=#666666')
