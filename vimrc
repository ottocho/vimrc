" ottocho
" Thu, Nov 01, 2018



""" vundle settings
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'L9'
Plugin 'tomasr/molokai'   " theme
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'xolox/vim-misc'
Plugin 'majutsushi/tagbar'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-eunuch'
Plugin 'scrooloose/nerdcommenter'
Plugin 'uarun/vim-protobuf'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'jparise/vim-graphql'
Plugin 'moll/vim-node'
Plugin 'w0rp/ale'
Plugin 'skywind3000/asyncrun.vim'
"
""" temporarily disabled packages
"" Plugin 'vim-scripts/a.vim'
"" Plugin 'Raimondi/delimitMate'
"" Plugin 'xolox/vim-easytags'
"" Plugin 'prettier/vim-prettier' https://prettier.io/docs/en/vim.html
"Plugin 'mxw/vim-jsx' have problem in indent
call vundle#end()



""" Plugin settings
" theme
colorscheme molokai
set background=dark
" scrooloose/nerdtree
let g:nerdtree_tabs_open_on_console_startup = 0   " not open on startup
" majutsushi/tagbar
"autocmd BufEnter * nested :call tagbar#autoopen(0)
" w0rp/ale
let g:ale_sign_error = '>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " not run linter on opening a new file
let g:ale_lint_on_text_changed = 0 " not run linter when text changed
let g:ale_lint_on_save = 1 " run linter when saving a file
" pangloss/vim-javascript.
let g:javascript_plugin_flow = 1  " enable flow
" mxw/vim-jsx
let g:jsx_ext_required = 0  " disable jsx extension for react



""" encoding
set fileencodings=utf-8,gb18030,utf-16,usc-bom,big5,latin1
set encoding=utf8
set termencoding=utf-8
"set termencoding=gb18030
"set fileencoding=utf8      "no need to set this



""" pasting
set t_BE=
if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
    cmap <Esc>[200~ <nop>
    cmap <Esc>[201~ <nop>
endif



""" indent
filetype plugin indent on
syntax enable
set autoindent
set smarttab
set cindent



""" tab and blank
set expandtab   " tab -> blank
set tabstop=4
set shiftwidth=4
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript.jsx setlocal ts=2 sw=2 expandtab
autocmd Filetype graphql setlocal ts=2 sw=2 expandtab
" note:
" ts = 'number of spaces that <Tab> in file uses'
" sts = 'number of spaces that <Tab> uses while editing'
" sw = 'number of spaces to use for (auto)indent step'



""" common config
set ignorecase smartcase
set wildmenu
set wildmode=list:longest
set foldmethod=manual
set helplang=cn
set sta
set backspace=indent,eol,start
set nocompatible
set number
set history=50
set matchpairs+=<:>        " add <> to match pairs
set ruler
set incsearch
set showmatch
set hlsearch
set winaltkeys=no
set showmode
set noignorecase
set autowrite
"set textwidth=80
"set colorcolumn=+1
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
set modelines=0
set splitright

" move between windows by Ctrl+j/k/h/l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" disable the F1
noremap <F1> <Esc>"

" break long lines
noremap <silent> j gj
noremap <silent> k gk
noremap <silent> 0 g0
noremap <silent> $ g$
noremap <silent> ^ g^
noremap <silent> _ g_

" multiple indent in visual mode
vnoremap < <gv
vnoremap > >gv

" return to last edit position when open the file
autocmd BufReadPost *
 \ if line("'\"") > 0 && line("'\"") <= line("$") |
 \   exe "normal! g`\"" |
 \ endif

" save whenever you lose focus
autocmd FocusLost * :wa

" delete trailing whitespace on save
func! DeleteTrailingWhiteSpace()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWhiteSpace()

" '*' and '#' to search the selected content(visual mode)
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
" Ctrl+H to search the selected content(visual mode)
vnoremap <silent> <C-H> :call VisualSelection('replace')<CR>

" keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz

" visual selection
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



" auto update the last modified time of Python file
"func! UpdateDate()
"  exe "normal my"
"  exe "1,8 s/Last modified:.*/Last modified:".strftime("  %Y-%m-%d %H:%M")."/e"
"  exe "normal `y"
"  exe "normal zz"
"endfunction
"autocmd BufWritePost *.py call UpdateDate()

" add title for new py file
function AddTitlePython()
    call setline(1, "#!/usr/bin/env python")
    call append(1, "#coding:utf8")
    call append(2,"")
    call append(3, '"""')
    call append(4,"Author:       ottocho")
    call append(5,"Filename:     " . expand("%"))
    call append(6,"Date:         ".strftime("%Y-%m-%d %H:%M"))
    call append(7,"Description:")
    call append(8,"")
    call append(9, '"""')
endf
"autocmd bufnewfile *.py call AddTitlePython()

" Make these commonly mistyped commands still work
command! WQ wq
command! Wq wq
command! Wqa wqa
command! W w
command! Q q



""" map leader
let mapleader = ","
let g:mapleader = ","



""" leader mapping
" ,n : toggle line number
nnoremap <silent> <leader>n :set nonumber!<CR>
" ,r : rotate windows
nnoremap <leader>r <C-W><C-R>
" ,s : clear out hilighting from search
noremap <leader>s :nohlsearch<cr>
" ,t : toggle tagbar
nmap <silent> <leader>t :TagbarToggle<CR>
" ,l : toggle nerd tree tabs
nmap <silent> <leader>l :NERDTreeTabsToggle<CR>
" ,v : vnew current file
nnoremap <leader>v :vnew %<CR>
" ,x : select all
"nnoremap <leader>x ggVG"
" ,r : run python
" nnoremap <leader>r :!/usr/bin/env python %<CR>
