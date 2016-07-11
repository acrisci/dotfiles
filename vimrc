"current project specific bindings
" <none>

"setup pathogen for runtime path manipulation
"filetype off

"always show the statusline
set laststatus=2
set encoding=utf8
set ambiwidth=single

call pathogen#infect()
call pathogen#helptags()

"detects filetype and uses appropriate hilighting
filetype plugin indent on
syntax on

"automatically changes the current directory to match the current file (may cause plugin problems)
"set autochdir

function! LinuxFormatting()
    setlocal tabstop=8
    setlocal shiftwidth=8
    setlocal softtabstop=8
    setlocal textwidth=80
    setlocal noexpandtab

    setlocal cindent
    setlocal formatoptions=tcqlron
    setlocal cinoptions=:0,l1,t0,g0
endfunction

function! TabFormatting()
    setlocal tabstop=4
    setlocal shiftwidth=4
    setlocal softtabstop=4
    setlocal textwidth=80
    setlocal noexpandtab

    setlocal cindent
    setlocal formatoptions=tcqlron
    setlocal cinoptions=:0,l1,t0,g0
endfunction

"convenience
nmap <C-v> "+p

"a function to compile less
function! BuildCSS()
endfunc

"a function that saves and builds the file
function! SaveAndBuild()
    silent write
    if(&filetype == 'less')
        silent call BuildCSS()
    endif
    echo strftime('%X') . ' : ' . expand('%X') ' : Write'
endfunc

function! OpenNERDTree()
    if(&filetype != 'nerdtree')
        NERDTree
        set relativenumber
    endif
endfunc

function! ToggleNERDTreeRN()
    NERDTreeToggle
    set relativenumber
endfunc

function! ToggleTlist()
  TlistToggle
  if(&filetype == 'taglist')
    set relativenumber
    "/\s\sfunction
  endif
endfunc

"delete html attribute
map <C-A-d> f"F=Bhd2f"

"the F keys
map <F2> :call ToggleNERDTreeRN()<CR>
map <F3> :call ToggleTlist()<CR>
nmap <F4> :ConqueTermSplit zsh<CR>

"don't give the ATTENTION message when an existing swap file is found (dangerous)
"set shortmess+=A

"set the colorscheme
syntax enable
set background=dark
colorscheme solarized
" Uncomment for 256 Colorscheme
" if !has('gui_running')
"   colorscheme wombat256
" endif

"set cursor options
hi cursor guibg=#D33682 guifg=#2AA198
set guicursor+=a:blinkon0

"set relative numbered lines on when the window is focused
function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc

function! RelativeNumberHandler()
  if(&filetype == 'taglist')
    set relativenumber
  else
    set relativenumber
  endif
endfunc

function! NumberHandler()
  if(&filetype == 'taglist')
    set relativenumber
  elseif(&filetype == 'nerdtree')
    set relativenumber
  else
    set number
  endif
endfunc

set relativenumber
"au FocusLost * call NumberHandler()
"au FocusGained * call RelativeNumberHandler()
"au BufEnter * call RelativeNumberHandler()
"au BufLeave * call NumberHandler()
nnoremap <C-n> :call NumberToggle()<CR>

"set font options
set guifont=Fira\ Mono\ 13

"set sql syntax hilighting (buggy)
let g:sql_type_default = 'mysql'

"lowercase searches are case insensitive, else sensitive
"set smartcase

"maps CTRL-<navigation> to navigate through windows
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

"maps CTRL-ALT-<navigation up/down> to navigate and maximize/minimize windows (resp.)
nmap <silent> <C-A-k> <C-w>k<C-W>_
nmap <silent> <C-A-j> <C-w>j<C-W>_

"insert spaces instead of a tab character
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

"Disable auto comment
au FileType * set fo-=c
au FileType * set fo-=r
au FileType * set fo-=o

"word definition keywords
set iskeyword=@,_,48-57,192-255,$,#

"custom syntax hilighting
au BufNewFile,BufRead *.phtml set syntax=phtml
au BufNewFile,BufRead *.jst set syntax=jst
au BufNewFile,BufRead *.md set ft=md
au BufNewFile,BufRead *.groovy setl cindent
"au BufNewFile,BufRead *.coffee,*.js set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
au BufNewFile,BufRead *.coffee set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

"switching
nmap <C-Tab> :bn!<CR>
nmap <C-S-Tab> :bp!<CR>
set guitablabel=%N)\ \ %t\ %m
nmap <A-1> 1gt
nmap <A-2> 2gt
nmap <A-3> 3gt
nmap <A-4> 4gt
nmap <A-5> 5gt
nmap <A-6> 6gt
nmap <A-7> 7gt
nmap <A-8> 8gt
nmap <A-9> 9gt
nmap <A-0> 10gt

"Open a new tab with NERDTree open
nmap <C-t> :tabnew +:NERDTree<CR>

"set scroll (<C-d>, <C-u>) to a value easier to follow
set scroll=8

"set Y to yank the whole page to the clipboard
nmap Y :%y+<CR>

"paragraph format
nmap Q gwap
imap <Alt-q> <c-o>gwip

"<C-d> is backspace like emacs
imap <c-d> <DEL>

"set window minimum height to zero
set winminheight=0

"turn off jshint error hilighting
let g:JSHintHighlightErrorLine = 0

"hide gui toolbar
set go-=T
"remove menu bar
set go-=m
"remove right-hand scrollbar
set go-=r
"no gui tab labels
"set go-=e
"remove left scrollbar
set go-=l
set go-=L
"use console dialogs instead of popups
set go+=c

"insert mode mappings
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

"supertab configuration
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menu,preview,longest

"autocmd
au BufEnter * set number

"filetype specific
au FileType php set omnifunc=phpcomplete#CompletePHP
"may conflict; mainly for /etc/supervisord.conf and ~/etc/supervisord/*.conf
au BufEnter *.conf set filetype=dosini
"au BufEnter *.md set filetype=markdown
au BufEnter *.html set filetype=liquid

"disable code folding
set nofoldenable

"ctrlp
nmap <leader>p :CtrlPTag<cr>

let g:ctrlp_extensions = ['tag', 'quickfix' ]
let g:ctrlp_custom_ignore = 'node_modules\|bower_components\|\.pyc$\|\.o$'

"taglist options
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

"clangcomplete options
let g:clang_complete_auto = 0
let g:clang_close_preview = 1
let g:clang_use_library = 1
let g:clang_library_path = '/usr/lib'

"syntastic options
let g:syntastic_always_populate_loc_list=1

"automatically update changes if RO
if &readonly
    set autoread
end

"leader shortcuts
nmap <leader>d :bdelete<CR>
nmap <leader>e :e 
nmap <leader>- :resize 10<CR>
nmap <leader><leader> :split<cr>
nmap <leader>t :TlistUpdate<CR>
nmap <leader>w :w<CR>
nmap <leader>] :CtrlPTag<CR>
nmap <leader>s :split<CR>

" airline
let g:airline_powerline_fonts=0
let g:airline_left_sep=' '
let g:airline_right_sep=' '

" jedi
autocmd FileType python setlocal completeopt -=preview
