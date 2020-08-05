"" VIM-PLUGIN SETTING START
"" To install new plugin -> vim +PlugInstall +qall
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

"" global tag system
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'

"" management preview window
Plug 'skywind3000/vim-preview'

"" build project asynchronously
Plug 'skywind3000/asyncrun.vim'

"" fuzzy search(file/function)
Plug 'Yggdroot/LeaderF'

"" complete
"" FIXME need python3 support
"" Plug 'ycm-core/YouCompleteMe'

"" dynamic syntax check
"" FIXME too slow Orz
""Plug 'dense-analysis/ale'

"" diif check
Plug 'mhinz/vim-signify', { 'branch': 'legacy' }

"" text object
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'

"" hotkey extention
Plug 'tpope/vim-unimpaired'

""
call plug#end()
"" VIM-PLUGIN SETTING END


"" =====================
"" CURSOR SETTING
"" cursor move
imap <C-k> <Esc><Up>a
imap <C-h> <Left>
imap <C-l> <Right>
imap <C-j> <Esc><Down>a

"" cursor shape in defferent mode
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

"" cursor settings:
"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar


"" =====================
"" TAB SETTING
"" tab
set tabstop=4
set shiftwidth=4
set expandtab

"" Use \t as tab in Makefile
autocmd BufReadPost Makefile,makefile,MakeFile :set expandtab&


"" =====================
"" Display SETTING
"" line number
set number
set relativenumber

"" disable error notify
set visualbell "" Sound
set t_vb=      "" Screen flash

"" high light
syntax on

"" scheme and color
syntax on

set t_Co=256
set background=dark
set cursorline
set cursorcolumn

colorscheme tender
"" set line number color
highlight LineNr ctermfg=black ctermbg=60


"" =====================
"" FORMAT SETTING
"" auto format space and tab before save↵
command Cln :silent! 1,$s/\t/    /g | :silent! 1,$s/\ \+$//g
autocmd BufWritePre *.c,*.h,*.py,*.cpp,*.sh :Cln

"" auto format with clang-format
autocmd BufWritePre *.c,*.h,*.cpp :ClangFormat

"" show format character
set listchars=eol:↵,tab:»·,trail:╳,extends:»,precedes:«
set list "" Make invisible charaters visible


"" =====================
"" AUTO COMPLETE
"" make up
inoremap ( ()<Esc>i
inoremap " ""<Esc>i
inoremap {<CR> {<CR>}<Esc>ko

"" YCM SETTINGS
"" minimun coplete charactor
"" let g:ycm_min_num_identifier_candidate_chars = 2

"" complete trigger
"" let g:ycm_semantic_triggers =  {
""            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
""            \ 'cs,lua,javascript': ['re!\w{2}'],
""            \ }


"" =====================
"" SYMBLE FINDING / DEFINITION
"" gtags
"" Find the given files to identify in a project or not
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

"" tag file name
let g:gutentags_ctags_tagfile = '.tags'

"" Enable gtags
let g:gutentags_modules = []
if executable('gtags-cscope') && executable('gtags')
    let g:gutentags_modules += ['gtags_cscope']
endif

"" Put the tag files into ~/.cache/tags directory
let g:gutentags_cache_dir = expand('~/.cache/tags')

"" For avoid auto add other project's data (That might be confuse)
let g:gutentags_auto_add_gtags_cscope = 0

"" enable advanced commands for debuging
let g:gutentags_define_advanced_commands = 1


"" =====================
"" PREVIEW WINDOW CONTROL
"" Open/Close preview window in quickfix
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

"" Quick scroll preview window
noremap <S-k> :PreviewScroll -1<cr>
noremap <S-j> :PreviewScroll +1<cr>


"" =====================
"" BUILD PROJECT
"" quickfix window height
let g:asyncrun_open = 6

"" ring the bell while build end
let g:asyncrun_bell = 1

"" set rootmark to identify project root
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']

"" Toggle quickfix window (F10)
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

"" build makefile by Cmake
nnoremap <silent> <F3> :AsyncRun -cwd=<root> cmake . <cr>

"" run current file
nnoremap <silent> <F4> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

"" build current file
nnoremap <silent> <F5> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

"" build
nnoremap <silent> <F6> :AsyncRun -cwd=<root> make <cr>

"" build and run
nnoremap <silent> <F7> :AsyncRun -cwd=<root> -raw make run <cr>

"" build and test
nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make test <cr>

"" compile singal file
nnoremap <silent> <F9> :AsyncRun gcc -c -Wall -O2 "$(VIM_FILEPATH)" <cr>

"" Help
function! BuildHelp()
    echo "<F3> Execute CMake"
    echo "<F4> Execute current file"
    echo "<F5> Build current file"
    echo "<F6> Build project(Makefile)"
    echo "<F7> Build and run project(run required in Makefile)"
    echo "<F8> Build and test project(test required in Makefile)"
    echo "<F9> Compile current file to object file"
endfunction

command! BuildHelp call BuildHelp()

"" =====================
"" diff check
set updatetime=100
command! Diff :SignifyDiff

"" =====================
noremap <F2> :LeaderfFunction!<cr>
