set nocompatible
filetype off

" Always show the statusline
set laststatus=2
set encoding=utf8
set ambiwidth=single

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'https://github.com/altercation/vim-colors-solarized'
Plugin 'https://github.com/Valloric/YouCompleteMe'
Plugin 'https://github.com/scrooloose/nerdtree'
Plugin 'https://github.com/ctrlpvim/ctrlp.vim'
Plugin 'https://github.com/vim-scripts/taglist.vim'
Plugin 'https://github.com/vim-airline/vim-airline'
Plugin 'https://github.com/vim-airline/vim-airline-themes'
Plugin 'https://github.com/PotatoesMaster/i3-vim-syntax'
Plugin 'https://github.com/pangloss/vim-javascript'
Plugin 'https://github.com/leafgarland/typescript-vim'
Plugin 'https://github.com/rdnetto/YCM-Generator'
Plugin 'https://github.com/stfl/meson.vim'
Plugin 'https://github.com/rust-lang/rust.vim'
Plugin 'https://github.com/cespare/vim-toml'
Plugin 'https://github.com/tpope/vim-fugitive'
Plugin 'https://github.com/dhruvasagar/vim-table-mode'
Plugin 'https://github.com/vim/killersheep'

call vundle#end()
filetype plugin indent on
syntax enable
set mouse=a
set incsearch nois

" grep command
command! -nargs=+ Grep execute 'silent grep! -I -r -n . -e "<args>" --exclude-dir=".git" --exclude-dir="env" --exclude="tags" --exclude-dir="build" --exclude-dir="old" --exclude="wlr.log"' | copen | execute 'silent /<args>'
nmap <leader>g :Grep <c-r>=expand("<cword>")<cr><cr>

" Look and feel
set guifont=Fira\ Mono\ 13
set guicursor+=a:blinkon0
set background=dark

" vim bug that sets cursor to blinking for some reason
au VimEnter * silent exec "!printf '\033[?12l'"

" worthless ex-mode
nmap Q <nop>

" Mouse
nmap <X1Mouse> <C-o>
nmap <X2Mouse> <C-i>

function! DistractionFreeMode()
    lclose
    cclose
    NERDTreeClose
endfunction

if has("gui_running")
    colorscheme solarized
    hi cursor guibg=#D33682 guifg=#2AA198
    map  <silent>  <S-Insert>  "+p
    imap <silent>  <S-Insert>  <Esc>"+pa
    set go-=T
    "remove menu bar
    set go-=m
    "remove right-hand scrollbar
    set go-=r
    "remove left scrollbar
    set go-=l
    set go-=L
    "use console dialogs instead of popups
    set go+=c

    nmap <silent> <C-[> :call DistractionFreeMode() <bar> noh<CR>
    nmap <silent> <Esc> :call DistractionFreeMode() <bar> noh<CR>
endif

" Disable code folding
set nofoldenable

" Relative line numbering
set number
set relativenumber

" Easy split navigation
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Spaces instead of tabs
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" Language specific
au BufEnter *.{js,ts,coffee,yml,yaml,rb} set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" Disable auto comment
au FileType * set fo-=c
au FileType * set fo-=r
au FileType * set fo-=o

" Buffer switch with ctrl tab
nmap <C-Tab> :bn!<CR>
nmap <C-S-Tab> :bp!<CR>

" Emacs
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>
imap <C-d> <Del>
imap <C-h> <BS>
imap <C-i> <Tab>
imap <C-v> <C-o>p
imap <C-a> <C-o>I
imap <C-e> <C-o>A
imap <C-k> <C-o>D
imap <C-u> <C-o>d^

" Leader shortcuts
nmap <leader><leader> :split<cr>
nmap <leader>w :w<CR>
nmap <leader>f :YcmDiags<CR>
nmap <leader>s /\%>80v.\+<CR>

" Airline
let g:airline_powerline_fonts=0
let g:airline_left_sep=' '
let g:airline_right_sep=' '
let g:airline_theme='solarized'

" Taglist
let g:Tlist_Show_One_File=1
let g:Tlist_Use_Right_Window = 1
let g:Tlist_Enable_Fold_Column = 0
let g:Tlist_Auto_Highlight_Tag = 0
let g:Tlist_Auto_Update = 1
let g:Tlist_GainFocus_On_ToggleOpen = 1
let g:Tlist_Highlight_Tag_On_BufEnter = 1
let g:Tlist_Compact_Format = 1
let g:Tlist_Sort_Type = 'name'
let g:Tlist_Inc_Winwidth=0
au InsertEnter * TlistSync

function! ToggleTlist()
  TlistToggle
  if(&filetype == 'taglist')
    set relativenumber
  endif
endfunc

map <F3> :call ToggleTlist()<CR>

" Ctrlp
nmap <leader>] :CtrlPTag<CR>

let g:ctrlp_extensions = ['tag', 'quickfix' ]
let g:ctrlp_custom_ignore =
    \ {
    \ 'dir': 'build\|node_modules\|old',
    \ 'file': '\.pyc$\|\.o$',
    \ }
"let g:ctrlp_working_path_mode = 'c'

" NERDTree
function! ToggleNERDTreeRN()
    NERDTreeToggle
    set relativenumber
endfunc

map <F2> :call ToggleNERDTreeRN()<CR>

" YouCompleteMe
set completeopt-=preview
let g:ycm_extra_conf_globlist = ['~/projects/*']
"let g:ycm_python_binary_path = '/usr/bin/python3'
"let g:ycm_rust_src_path = '~/projects/rust/src'
let g:ycm_always_populate_location_list = 1
let g:ycm_min_num_of_chars_for_completion = 99
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
nmap <2-LeftMouse> :YcmCompleter GoTo<CR>

" JSX
let g:jsx_ext_required = 0

" Project specific options
function! TabFormatting()
    setlocal tabstop=4
    setlocal shiftwidth=4
    setlocal softtabstop=4
    setlocal noexpandtab
endfunction

autocmd BufRead,BufNew ~/projects/sway/* call TabFormatting()
autocmd BufRead,BufNew ~/projects/wlroots/* call TabFormatting()

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/
