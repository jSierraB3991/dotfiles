set autoindent
set expandtab
set softtabstop=4
set shiftwidth=4
set shiftround

set number
syntax on
set cursorline
set relativenumber


set textwidth=80
set colorcolumn=+1

set incsearch
set hlsearch



"Auto instalaci`on de plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs 
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
