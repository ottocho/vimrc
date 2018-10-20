" ottocho
" 2018.09.19


""" encoding
set fileencodings=utf-8,gb18030,utf-16,usc-bom,big5,latin1
set encoding=utf8
set termencoding=utf-8
"set termencoding=gb18030
"set fileencoding=utf8      "no need to set this

set t_BE=

""" indent
filetype plugin indent on
syntax enable
set smartindent "set cindent "set autoindent


""" tab and blank
""" ts = 'number of spaces that <Tab> in file uses'
""" sts = 'number of spaces that <Tab> uses while editing'
""" sw = 'number of spaces to use for (auto)indent step'
set expandtab   " tab -> blank
set tabstop=4
set shiftwidth=4
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype vue.html.javascript.css setlocal ts=2 sw=2 expandtab

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

" return to last edit position
if has("autocmd")
  autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
endif

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

" auto update the `last modified time`
func! UpdateDate()
  exe "normal my"
  exe "1,8 s/Last modified:.*/Last modified:".strftime("  %Y-%m-%d %H:%M")."/e"
  exe "normal `y"
  exe "normal zz"
endfunction
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
autocmd bufnewfile *.py call AddTitlePython()

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
" ,p : toggle paste mode
set pastetoggle=<leader>p
" ,n : toggle line number
nnoremap <silent> <leader>n :set nonumber!<CR>
" ,r : run python
nnoremap <leader>r :!/usr/bin/env python %<CR>
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
" ,r : rotate windows
" nnoremap <leader>r <C-W><C-R>




""" vundle settings
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'L9'
" theme
"Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
" tag and tab
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar'
" git support
"Plugin 'airblade/vim-gitgutter'
"Plugin 'tpope/vim-fugitive'
" swtich between source files and header files
Plugin 'vim-scripts/a.vim'
"Plugin 'Raimondi/delimitMate'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-eunuch'
Plugin 'scrooloose/nerdcommenter'
Plugin 'uarun/vim-protobuf'
Plugin 'posva/vim-vue'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'jparise/vim-graphql'


call vundle#end()



""" Plugin settings

"" Plugin 'altercation/vim-colors-solarized'
"colorscheme solarized
colorscheme molokai
set background=dark

"" Plugin 'scrooloose/nerdtree'
" 1/0: y/n NERDTree open on startup
let g:nerdtree_tabs_open_on_console_startup = 0

"" Plugin 'xolox/vim-easytags'
" Where to look for tags files
"set tags=./.tags,./tags,../tags,~/.vimtags  " project specific tags
"let g:easytags_dynamic_files = 2
"let g:easytags_file = '~/.tags' " global tag
"let g:easytags_events = ['BufReadPost', 'BufWritePost']
"let g:easytags_async = 1
"let g:easytags_resolve_links = 1
"let g:easytags_suppress_ctags_warning = 1

"" Plugin 'majutsushi/tagbar'
" 0: y/n automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)
"
"" Plugin 'Raimondi/delimitMate'
"let delimitMate_expand_cr = 1
"augroup mydelimitMate
"  au!
"  "au FileType cpp let b:delimitMate_autoclose = 1
"  au FileType cpp let b:delimitMate_matchpairs = "(:),[:],{:}"
"  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
"  au FileType tex let b:delimitMate_quotes = ""
"  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
"  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
"augroup END


"
" vue
let g:vue_disable_pre_processors=1
"autocmd FileType vue syntax sync fromstart
"autocmd FileType vue.html.javascript.css syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
