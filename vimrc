set tabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber

set visualbell
set t_vb=

"" auto format space and tab before save↵
command Cln :silent! 1,$s/\t/    /g | :silent! 1,$s/\ \+$//g
autocmd BufWritePost *.c,*.h,*.py,*.cpp,*.sh :Cln

"" high light
syntax on

"" Use \t as tab in Makefile
autocmd BufReadPost Makefile,makefile,MakeFile :set expandtab&

"" show format character
set listchars=eol:↵,tab:»·,trail:╳,extends:»,precedes:«
set list

"" make up
inoremap ( ()<Esc>i
inoremap " ""<Esc>i
inoremap {<CR> {<CR>}<Esc>ko

"" cursor move
imap <C-k> <Esc><Up>a
imap <C-h> <Left>
imap <C-l> <Right>
imap <C-j> <Esc><Down>a

if exists("syntax_on")
  syntax reset
endif

set t_Co=256
let g:colors_name = "monokai"
