vim.keymap.set('n', '<C-t>', function()
  -- Get current line
  local line = vim.api.nvim_get_current_line()
  
  -- Extract filepath from the line (after status indicators)
  local filepath = line:match('^%s*[MADRCU?!]%s+(.+)$')
  
  if filepath then
    -- Trim any trailing whitespace
    filepath = filepath:gsub('%s+$', '')
    
    -- Open file in new tab
    vim.cmd('tabedit ' .. vim.fn.fnameescape(filepath))
  end
end, { buffer = true, desc = 'Open file under cursor in new tab' })
