" Split file in new tab.
function git#SplitInNewTab()
    let file = split(getline("."))[1]
    execute ":tabnew"
    execute ":e" file
    execute ":Gvdiffsplit!"
endfunction

" TODO: add check if within git repository
function git#ListFiles()
  if $GIT_DIR == "/home/gam/.cfg"
    execute ":GFiles"
  else
    execute "lua require('telescope.builtin').git_files()"
  endif
endfunction
