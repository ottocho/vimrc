" ottocho
" 2014.01.01

let mapleader = ","
let g:mapleader = ","

" encoding
set fileencodings=utf-8,gb18030,utf-16,usc-bom,big5,latin1
set encoding=utf8
  set termencoding=utf-8
  "set termencoding=gb18030
"set fileencoding=utf8      "no need to set this

"        filetype plugin indent on
"        set autoindent
"        set smartindent

"set backup " make backup files

"set cin
set ignorecase smartcase
set wildmenu
set foldmethod=manual
set helplang=cn
set sta
set backspace=2
syntax enable
set nocompatible
set number
set history=50
set background=dark
set tabstop=4
set matchpairs+=<:>        " add <> to match pairs
set shiftwidth=4
set showmatch
set ruler
set expandtab
set incsearch
set hlsearch
set winaltkeys=no
set showmode
set noignorecase
set autowrite
"set textwidth=80
set guioptions-=T
set noerrorbells
set winaltkeys=no
set novisualbell
set t_vb=       " disable visual bell
set noexrc      " don't use local version of .(g)vimrc, .exr
set cpoptions=aABceFsmq
set cmdheight=1
set laststatus=2
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)

" move between windows by Ctrl+j/k/h/l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" disable the F1
noremap <F1> <Esc>"

" break long lines
map j gj
map k gk

" http://www.vim.org/scripts/script.php?script_id=273
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1

" return to last edit position
if has("autocmd")
  autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
endif

" delete trailing whitespace on save
func! DeleteTrailingWhiteSpace()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWhiteSpace()

" multiple indent in visual mode
vnoremap < <gv
vnoremap > >gv
" '*' and '#' to search the selected content(visual mode)
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
" Ctrl+H to search the selected content(visual mode)
vnoremap <silent> <C-H> :call VisualSelection('replace')<CR>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz

" theme (https://github.com/altercation/vim-colors-solarized)
colorscheme solarized
if has('gui_running')
  set background=light
else
  set background=dark
endif

" auto update the `last modified time`
func! UpdateDate()
  exe "normal my"
  exe "1,8 s/Last modified:.*/Last modified:".strftime("  %Y-%m-%d %H:%M")."/e"
  exe "normal `y"
  exe "normal zz"
endfunction
autocmd BufWritePost *.py call UpdateDate()

" add title for new py file
function AddTitlePython()
    call setline(1, "#!/usr/bin/env python")
    call append(1, "#coding:utf8")
    call append(2,"")
    call append(3, '"""')
    call append(4,"Author:         ottocho")
    call append(5,"Filename:       " . expand("%"))
    call append(6,"Last modified:  ".strftime("%Y-%m-%d %H:%M"))
    call append(7,"Description:")
    call append(8,"")
    call append(9, '"""')
endf
autocmd bufnewfile *.py call AddTitlePython()

" leader map
" ,n toggle line number
nnoremap <silent> <leader>n :set nonumber!<CR>
" ,p run python
nnoremap <leader>p :!python2.7 %<CR>
" ,r rotate windows
nnoremap <leader>w <C-W><C-R>
" ,q :q
nnoremap <leader>q :q<CR>
" ,w :w
nnoremap <leader>w :w<CR>
" ,s : select all
map <Leader>a ggVG"

