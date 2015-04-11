" ottocho
" 2015.04.11


""" encoding
set fileencodings=utf-8,gb18030,utf-16,usc-bom,big5,latin1
set encoding=utf8
set termencoding=utf-8
"set termencoding=gb18030
"set fileencoding=utf8      "no need to set this



""" indent
"filetype plugin indent on
set smartindent "set cindent "set autoindent
"set expandtab   " tab -> blank



""" common config
syntax enable
set gdefault
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
set background=dark
set tabstop=4
set matchpairs+=<:>        " add <> to match pairs
set shiftwidth=4
set ruler
set incsearch
set showmatch
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
autocmd BufWritePost *.py call UpdateDate()

" add title for new py file
function AddTitlePython()
    call setline(1, "#!/usr/bin/python2.7")
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
" ,a : select all
nnoremap <leader>a ggVG"
" ,l : nerd tree tabs
nmap <silent> <leader>l :NERDTreeTabsToggle<CR>
" ,n : toggle line number
nnoremap <silent> <leader>n :set nonumber!<CR>
" ,p : run python
nnoremap <leader>p :!python2.7 %<CR>
" ,r : rotate windows
nnoremap <leader>r <C-W><C-R>
" ,s : clear out hilighting from search
noremap <leader>s :nohlsearch<cr>
" ,t : Open/close tagbar with
nmap <silent> <leader>t :TagbarToggle<CR>




""" vundle settings
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('/home/ottocho/.vim/bundle/')
Plugin 'gmarik/Vundle.vim'
Plugin 'L9'
" theme
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
" tag and tab
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar'
" git support
"Plugin 'airblade/vim-gitgutter'
"Plugin 'tpope/vim-fugitive'
" swtich between source files and header files
Plugin 'vim-scripts/a.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-eunuch'
Plugin 'scrooloose/nerdcommenter'
Bundle 'uarun/vim-protobuf'
call vundle#end()



""" Plugin settings

"" Plugin 'altercation/vim-colors-solarized'
set background=dark
colorscheme solarized

"" Plugin 'scrooloose/nerdtree'
" 1/0: y/n NERDTree open on startup
let g:nerdtree_tabs_open_on_console_startup = 0

"" Plugin 'xolox/vim-easytags'
" Where to look for tags files
"set tags=./.tags,./tags,../tags,~/.vimtags  " project specific tags
"let g:easytags_dynamic_files = 2
let g:easytags_file = '~/.tags' " global tag
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

"" Plugin 'majutsushi/tagbar'
" 0: y/n automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)
"
"" Plugin 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

