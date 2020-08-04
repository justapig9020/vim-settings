"" vim-plug settings
call plug#begin('~/.vim/plugged')

"" Formater
Plug 'rhysd/vim-clang-format', { 'on': 'ClangFormat'}

"" colorscheme list
"" More scheme:
""      - https://github.com/rafi/awesome-vim-colorschemes
"" Plug 'sickill/vim-monokai'
"" Plug 'rakr/vim-two-firewatch'
"" Plug 'arcticicestudio/nord-vim'
"" Plug 'gilgigilgil/anderson.vim'
"" Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'jacoborus/tender.vim'

""

call plug#end()
"" vim-plug settings end

"" ==== CURSOR ====
"" cursor move
imap <C-k> <Esc><Up>a
imap <C-h> <Left>
imap <C-l> <Right>
imap <C-j> <Esc><Down>a

"" Mode Settings
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

"" Cursor settings:

"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

"" tab
set tabstop=4
set shiftwidth=4
set expandtab

"" Use \t as tab in Makefile
autocmd BufReadPost Makefile,makefile,MakeFile :set expandtab&

"" line number
set number
set relativenumber

"" disable error notify
set visualbell "" Sound
set t_vb=      "" Screen flash

"" auto format space and tab before save↵
command Cln :silent! 1,$s/\t/    /g | :silent! 1,$s/\ \+$//g
autocmd BufWritePre *.c,*.h,*.py,*.cpp,*.sh :Cln

"" auto format with clang-format
autocmd BufWritePre *.c,*.h,*.cpp :ClangFormat

"" high light
syntax on

"" show format character
set listchars=eol:↵,tab:»·,trail:╳,extends:»,precedes:«
set list "" Make invisible charaters visible

"" make up
inoremap ( ()<Esc>i
inoremap " ""<Esc>i
inoremap {<CR> {<CR>}<Esc>ko

"" scheme and color
syntax on

set t_Co=256
set background=dark
set cursorline
set cursorcolumn

colorscheme tender
"" set line number color
highlight LineNr ctermfg=black ctermbg=60
