" Set color scheme.
colorscheme default
set background=dark

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" filetype off
syntax on

" filetype on
" filetype plugin on
" filetype indent on

set mouse=a

" Style cursor
set guicursor=n-v-c-sm:ver25,i-ci-ve:ver25,r-cr-o:hor20

" Highlight cursor line horizontally/vertically.
" set cursorline
" set cursorcolumn

set tabstop=4
set shiftwidth=4
set expandtab
set textwidth=100

" Do not save backup files
set nobackup

set scrolloff=7
set wrap

" Highlight, incremental search
set hlsearch
set incsearch

set ignorecase
set smartcase

set showcmd
set showmode
" set ttyfast

" Show matching words during a search.
" set showmatch
" set matchpairs

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ %l,%c\ %p%%

" Show the status on the second to last line.
set laststatus=2

" }}}
