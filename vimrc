execute pathogen#infect()
" Pluigins:
"  - Pathogen(loader): https://github.com/tpope/vim-pathogen
"  - NERDTree:         https://github.com/scrooloose/nerdtree
"  - SimplyFold:       https://github.com/tmhedberg/SimpylFold
"  - vim-sensible:     https://github.com/tpope/vim-sensible 
"  - vim-javascript    https://github.com/pangloss/vim-javascript

set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

set history=1000
set wildmenu wildmode=longest:full,full
set ruler showcmd
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set hlsearch incsearch magic
set noerrorbells visualbell t_vb=
set background=dark
set encoding=utf8
set nobackup nowritebackup noswapfile
set smartcase
set showfulltag
set scrolloff=5 sidescrolloff=5
set hidden
set number
set smartindent autoindent smarttab cindent
set autoread
set ts=4 sw=4 sts=4
set mouse=a
set timeoutlen=200
set comments=sl:/*,mb:\ *,elx:\ */

set background=dark

autocmd FileType c          setlocal makeprg=gcc\ '%'\ -o\ '%:r'\ -std=gnu11\ -Wall
autocmd FileType cpp        setlocal makeprg=g++\ '%'\ -o\ '%:r'\ -std=c++11\ -Wall
autocmd FileType haskell    setlocal makeprg=ghc\ --make\ '%'
autocmd Filetype cs         setlocal makeprg=mcs\ '%'\ -r:System.Numerics
autocmd Filetype rust		setlocal makeprg=rustc\ '%'\ -o\ '%:r'
autocmd Filetype ocaml		setlocal makeprg=ocamlopt\ '%'\ -o\ '%:r'

autocmd FileType haskell    setlocal shellpipe=2> expandtab
autocmd FileType cabal      setlocal expandtab
autocmd FileType python     setlocal expandtab
autocmd Filetype html       setlocal ts=2 sts=2 sw=2
autocmd Filetype xml        setlocal ts=2 sts=2 sw=2

function! ExecuteIfNoErrors()
	if len(getqflist()) == 0
		call ExecuteFile()
	endif
endfunction

function! ExecuteFile()
	if has('terminal')
		if &filetype == "sh"
			write
			terminal bash "%"
		elseif &filetype == "python"
			write
			terminal python "%"
		elseif &filetype == "javascript"
			write
			terminal node "%"
		elseif &filetype == "c" || &filetype == "cpp" || &filetype == "haskell" || &filetype == "rust" || &filetype == "ocaml"
			terminal "%:p:r"
		elseif &filetype == "cs"
			terminal mono "%:p:r.exe"
		endif
	else " TODO: remove dublicated stuff here
		if &filetype == "sh"
			write
			!bash "%"
		elseif &filetype == "python"
			write
			!python "%"
		elseif &filetype == "javascript"
			write
			!node "%"
		elseif &filetype == "c" || &filetype == "cpp" || &filetype == "haskell" || &filetype == "rust" || &filetype == "ocaml"
			!"%:p:r"
		elseif &filetype == "cs"
			!mono "%:p:r.exe"
		endif
	endif
endfunction

map <F9> <ESC> :w<CR>:make<CR><CR>:call ExecuteIfNoErrors()<CR>
imap <F9> <ESC> :w<CR>:make<CR><CR>:call ExecuteIfNoErrors()<CR>

nmap <F2> :w<CR>
imap <F2> <ESC>:w<CR>i

map <C-N> :NERDTreeToggle <CR>
map <C-T> :tabnew <CR>
map <C-O> :tabnew <bar> :e . <CR>
map <C-W> :q <CR>
imap <C-W> :w <bar> :q <CR>

map <C-left> :tabprevious <CR>
map <C-right> :tabnext <CR>

map <F5> <ESC> :w <bar> !xclip -selection clipboard < % <CR>
map <F10> <ESC> :wa <bar> !make <CR>

"Compile a basic program
"map <F8> <ESC>:w <bar> !./compile_cpp.sh <CR>
"
autocmd Filetype java       map <F9> <ESC>:w <bar> !javac % && java %:r <CR>
autocmd Filetype php        map <F9> <ESC>:w <bar> !php % <CR>
autocmd Filetype php        imap <F9> <ESC>:w <bar> !php % <CR>
autocmd Filetype tex        map <F9> <ESC>:w <bar> !xelatex -interaction=nonstopmode -halt-on-error % <CR>

"let g:airline#extensions#tabline#enabled = 1

let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
set completeopt-=preview

let c_no_curly_error=1
let g:badwolf_darkgutter = 1
let g:badwolf_tabline = 2
colorscheme badwolf

nmap <Tab> mtgg=G't

autocmd QuickFixCmdPost [^l]* nested cwindow

autocmd BufNewFile  *.cpp  0r ~/.vim/skeleton.cpp
hi StatusLine ctermbg=black ctermfg=white 
source ~/.vim/cyrilic.vim
