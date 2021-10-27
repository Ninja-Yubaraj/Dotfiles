" _   _ _        _        __   __     _                      _ 
"| \ | (_)_ __  (_) __ _  \ \ / /   _| |__   __ _ _ __ __ _ (_)
"|  \| | | '_ \ | |/ _` |  \ V / | | | '_ \ / _` | '__/ _` || |    Yubaraj Sarkar (Ninja-Yubaraj)
"| |\  | | | | || | (_| |   | || |_| | |_) | (_| | | | (_| || |    https://github.com/Ninja-Yubaraj
"|_| \_|_|_| |_|/ |\__,_|___|_| \__,_|_.__/ \__,_|_|  \__,_|/ |    
"             |__/     |_____|                            |__/ 
" My init.vim config. I like to put everything in one file.


set nocompatible              " be iMproved, required
filetype off                  " required


"-----------------------------------------------------------------------------------------------------------------------
" => General Settings
"-----------------------------------------------------------------------------------------------------------------------
" set leader key
let g:mapleader = "\<Space>"

syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			            " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=0                        " Always display the status line
set number                              " Line numbers
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
"set autochdir                           " Your working directory will always be the same as your working directory

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC

" You can't stop me
cmap w!! w !sudo tee %


"-----------------------------------------------------------------------------------------------------------------------
" => Remapping Keys
"-----------------------------------------------------------------------------------------------------------------------
" Better nav for omnicomplete
"inoremap <expr> <c-j> ("\<C-n>")
"inoremap <expr> <c-k> ("\<C-p>")

" Use alt + hjkl to resize windows
"nnoremap <M-j>    :resize -2<CR>
"nnoremap <M-k>    :resize +2<CR>
"nnoremap <M-h>    :vertical resize -2<CR>
"nnoremap <M-l>    :vertical resize +2<CR>

" I hate escape more than anything else
"inoremap jk <Esc>
"inoremap kj <Esc>

" Easy CAPS
"inoremap <c-u> <ESC>viwUi
"nnoremap <c-u> viwU<Esc>

" TAB in general mode will move to text buffer
"nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
"nnoremap <S-TAB> :bprevious<CR>

" Alternate way to save
"nnoremap <C-s> :w<CR>
" Alternate way to quit
"nnoremap <C-Q> :wq!<CR>
" Use control-c instead of escape
"nnoremap <C-c> <Esc>
" <TAB>: completion.
"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
"vnoremap < <gv
"vnoremap > >gv

" Better window navigation
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l

"nnoremap <Leader>o o<Esc>^Da
"nnoremap <Leader>O O<Esc>^Da


"-----------------------------------------------------------------------------------------------------------------------
" => Plugins and vim-plug
"-----------------------------------------------------------------------------------------------------------------------

""" Auto-Install Vim-Plug """
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

""" Plugins """
call plug#begin('~/.config/nvim/plugged')

Plug 'sheerun/vim-polyglot'               " Better Syntax Support
Plug 'scrooloose/NERDTree'                " File Explorer
Plug 'jiangmiao/auto-pairs'               " Auto pairs for '(' '[' '{'
"Plug 'dracula/vim', { 'as': 'dracula' }   " Dracula Theme

call plug#end()
