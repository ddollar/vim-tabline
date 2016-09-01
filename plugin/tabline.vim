" tabline.vim
" Author:  David Dollar <david@dollar.io>
" URL:     https://github.com/ddollar/vim-tabline
" Version: 0.1
" License: MIT

function! TabLabel(n)
  let label  = ''
  let label .= a:n                             " set tab page number
  let buflist = tabpagebuflist(a:n)
  let label .= ' '
  let winnr    = tabpagewinnr(a:n)               " focused window number
  let fullname = bufname(buflist[winnr - 1])     " absolute file name
  let filename = fnamemodify(fullname, ':t')     " basename
  if filename == ''                              " empty buffers have No Name
    let filename = '[unnamed]'
  endif
  let label   .= fullname                        " add filename to label
  for bufnr in tabpagebuflist(a:n)
    if getbufvar(bufnr, '&modified')             " unsaved modified buffer?
      let label .= '[+]'
      break
    endif
  endfor
  return label
endfunction

function! TabLine()
  let s = ''
  for i in range(tabpagenr('$'))                 " for each open tab..
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'                   " make active tab stand out
    else
      let s .= '%#TabLine#'
    endif
    let s .= ' '
    let s .= '%{TabLabel(' . (i + 1) . ')}'    " add tab label
    let s .= ' '
    let s .= '%#TabLine#'                        " reset highlight
    let s .= '%#TabLineFill# %#TabLine#'
  endfor
  let s .= '%#TabLineFill#'                    " :help statusline
  return s
endfunction
