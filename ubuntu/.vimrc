
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
 "Plugin 'L9'

"--- Visual Look ---
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'ryanoasis/vim-devicons'         "Cool custom icons for Vim
                                         " WARNING: Requires installing a
                                         " custom NERD compitalble font:
                                         " https://github.com/ryanoasis/nerd-fonts


"--- Navigation ---
Plugin 'scrooloose/nerdtree'
Plugin 'xuyuanp/nerdtree-git-plugin'    "Git plugin for Nerdtree
"Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
"Plugin 'tpope/vim-repeat'               " Remaps the '.' to work (i.e repeat) on other pluguns.
"Plugin 'glts/vim-radical'               " Changes the base of a number dec,hex,oct,bin
Plugin 'ReplaceWithRegister'             " Replaces current text with contents of a register
Plugin 'easymotion/vim-easymotion'
Plugin 'kien/ctrlp.vim'
"Plugin 'brookhong/cscope.vim'          "For navigating large code bases
                                        "Tutorial: http://cscope.sourceforge.net/large_projects.html

"--- Git stuff ---
Plugin 'airblade/vim-gitgutter'

"--- Code completion ---
Plugin 'valloric/youcompleteme'
"Plugin 'rdnetto/ycm-generator'
"Plugin 'neoclide/coc.nvim'              " Visual Sudio Code like completion
                                         "Tutorial: https://www.youtube.com/watch?v=gnupOrSEikQ

"--- C++ (and other languages) ---
Plugin 'tpope/vim-surround'             " All about surrounding \", \', ({[ and much more
"Plugin 'scrooloose/syntastic'
"Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/nerdcommenter'
Plugin 'yggdroot/indentline'
Plugin 'chiel92/vim-autoformat'
"Plugin 'kien/rainbow_parentheses.vim'
"Plugin 'puremourning/vimspector'
Plugin 'godlygeek/tabular'
"Plugin 'junegunn/vim-easy-align'
"Plugin 'ervandew/supertab'
Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'artur-shaik/vim-javacomplete2'
"Plugin 'vhdirk/vim-cmake'
"Plugin 'grailbio/bazel-compilation-database'
"Plugin 'severin-lemaignan/vim-minimap'   "Sublime text like preview pannel at
                                             "the left. I didn't like it.
"Plugin 'honza/vim-snippets'     "Snippets
Plugin 'sirver/ultisnips'        " Snippets
"Plugin 'taglist.vim'            "source code browser plugin for Vim
Plugin 'majutsushi/tagbar'       "A class outline viewer for Vim (IMHO better one)
"Plugin 'libclang-vim/vim-textobj-clang'    " This was giving errors when enabled
"Plugin 'bps/vim-textobj-python'



"--- LaTeX stuff ---
"Plugin 'lervag/vimtex'             "Latex plugin for Vim, I don't know what it
                                    "  exactly does...
Plugin 'vim-latex/vim-latex'
Plugin 'xuhdev/vim-latex-live-preview'  "This works fine without any adtional 
                                        " Latex plugins


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"---------------------------------------------------------------------------
"---------------------------------------------------------------------------



"---------------------------------------------------------------------------
"---------------------------------------------------------------------------

" MAKE SURE to copy 'compile_commands.json' file somewhere in the root
"  of the project:
let g:ycm_use_clangd = 1                " Enable clangd 
let g:ycm_disable_signature_help = 0    " Disable signature help ??
autocmd CompleteDone * pclose           " Auto hides the annoying signature 
                                        "  preview window
"let g:ycm_global_ycm_extra_conf = "~/Temp/cyclicshift/Source/Projects/Linux/.ycm_extra_conf.py"

"---------------------------------------------------------------------------



set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"set mouse=a

set background=dark
colorscheme PaperColor

set textwidth=80
set colorcolumn=+1

"Alternate to color column above. It doesn't show the column but highlights
" everything in RED that crosses the 80 char column mark :
"au BufWinEnter * let w:m2=matchadd('ErrorMsg','\%>80v.\+',-1)

set noswapfile

set nobackup
set noswapfile

set cursorline
set ttyfast
set ruler
set relativenumber
set number
"set norelativenumber

set hlsearch        " enable search result highlighting
"nmap <F7> :noh<CR>


"--------------------------------------------------------------------
" NERDTree configuration:

" Start NERDTree automatically:(Now start vim with plain 'vim', not 'vim .')
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


" Executing vim ~/some-directory will open NERDTree and a new edit window.
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

"--------------------------------------------------------------------


"--------------------------------------------------------------------
" IndentLine Settings:

let g:indentLine_enabled = 0 

let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

"--------------------------------------------------------------------


"--------------------------------------------------------------------
" TagBar Settings:
" What's the right statement to automatically open up TagBar each time?
nmap <F8> :TagbarToggle<CR>
let g:tagbar_show_linenumbers = 2

"--------------------------------------------------------------------


"--------------------------------------------------------------------
" VimTex Settings:
"let g:tex_flavor = 'latex'
"let g:vimtex_latexmk_enabled = 0

" Vim LaTex Live Preview Settings:
autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'evince'
"let g:livepreview_engine = 'your_engine' . ' [options]'
"let g:livepreview_cursorhold_recompile = 0

"--------------------------------------------------------------------


noremap <F10> :cd ~/Temp/cyclicshift/Game/Linux/<CR> :!rm CyclicShift<CR> :cd ../../Temp/Linux<CR> :!cmake -DCMAKE_BUILD_TYPE=Debug -G "Unix Makefiles" ../../Source/Projects/Linux<CR><CR> :!make<CR><CR> :!cp compile_commands.json ../../<CR> :cd ../../Game/Linux<CR> :!./CyclicShift <CR><CR> <BAR> copen<CR>


noremap <leader>p :cd ~/Temp/cyclicshift/Game/Linux/<CR> :!rm CyclicShift<CR> :cd ../../Temp/Linux<CR> :!make<CR><CR> :!cp compile_commands.json ../../<CR> :cd ../../Game/Linux<CR> :!./CyclicShift <CR><CR>
