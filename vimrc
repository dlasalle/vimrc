if filereadable("${HOME}/.vimrc-standard")
    source ${HOME}/.vimrc-standard
endif
" indentations junk
set autoindent
" set cindent
set cinkeys-=0#
set indentkeys-=0#
set tabstop=2
set shiftwidth=2
set expandtab ts=2 sw=2 ai

set encoding=utf-8

" don't add spaces after periods
set nojoinspaces

" set line length and auto wrapping
set colorcolumn=80
set tw=79

" display 
syntax on
set showmatch
set number
set modeline
set ls=2

" doxygen
let s:meNameEmail="NAME <EMAIL>"
let s:copyrightMe="Copyright YEAR"
let g:DoxygenToolkit_commentType="C"
let g:DoxygenToolkit_authorName=s:meNameEmail."\<enter>* ".s:copyrightMe
let g:DoxygenToolkit_versionString="1"
let g:DoxygenToolkit_maxFunctionProtoLines="30"

" comments
set comments=sl:/*,mb:\ *,elx:\ */

" misc
set backspace=2
hi clear SpellLocal
hi SpellLocal cterm=underline

" custom highlighting
:highlight WrappedLine ctermfg=red guifg=red

" auto commands
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufRead,BufNewFile *.txt set filetype=text
autocmd BufRead,BufNewFile *.h set filetype=c
autocmd BufRead,BufNewFile *.go set filetype=go
autocmd BufRead,BufNewFile *.py set filetype=python
autocmd FileType tex setlocal spell spelllang=en_us
autocmd FileType text setlocal spell spelllang=en_us
autocmd FileType markdown setlocal spell spelllang=en_us
autocmd FileType html setlocal spell spelllang=en_us
autocmd FileType tex setlocal noautoindent
autocmd FileType tex setlocal nocindent
autocmd FileType tex setlocal nosmartindent
autocmd FileType tex setlocal indentexpr=
autocmd FileType c set cindent
autocmd FileType go set tabstop=4
autocmd FileType go set shiftwidth=4
autocmd FileType go set noexpandtab 
autocmd FileType python set tabstop=4
autocmd FileType python set shiftwidth=4

" enable spell check toggling
map <F7> :setlocal spell! spelllang=en_us<CR>

autocmd FileType c match WrappedLine /\\$/


" syntastic
let g:syntastic_cpp_compiler_options = '-std=c++11'
let g:syntastic_python_pylint_args = '--disable=not-context-manager,missing-docstring,no-else-return,too-many-arguments'


" custom functions
fu! SectionCommentFunc( name )
  let width = 79 
  let len = width - 3 - strlen(a:name)
  set paste
  execute "normal o" . "/" . repeat("*",width-1)
  execute "normal o" . " * " . a:name . " " . repeat("*",len-1) 
  execute "normal o" . " " . repeat("*",width-2) . "/"
  execute "normal o" . ""
  execute "normal o" . ""
  set nopaste 
endfunction
fu! SubSectionCommentFunc( name )
  let width = 79 
  let len = width - 5 - strlen(a:name)
  set paste
  execute "normal o" . "/* " . a:name . " " . repeat("*",len) . "/" 
  execute "normal o" . ""
  set nopaste 
endfunction
fu! DefProtectFunc( name )
  set paste
  execute "normal o" . "#ifndef " . a:name
  execute "normal o" . "#define " . a:name
  execute "normal o" . ""
  execute "normal o" . "#endif"
  set nopaste
endfunction

" custom commands
command Diff vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
command Section :call SectionCommentFunc(input("Enter Section Title: "))
command Subsection :call SubSectionCommentFunc(input("Enter Subsection Title: "))
command DefProtect :call DefProtectFunc(input("Enter Name: "))
command Date :r !date +\%Y.\%m.\%d
command Constructors :call SectionCommentFunc("CONSTRUCTORS / DESTRUCTOR")
command Constants :call SectionCommentFunc("CONSTANTS")
command Public :call SectionCommentFunc("PUBLIC FUNCTIONS")
command Private :call SectionCommentFunc("PRIVATE FUNCTIONS")

