" An example for a vimrc file.
"
" Many settings from
" https://github.com/spf13/spf13-vim/blob/1ce5f23997f6dd82235c6936c5c47b3f1d1b4e50/.vimrc.bundles
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'klen/python-mode'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'gcmt/wildfire.vim'
Bundle 'tpope/vim-commentary'
Bundle 'luochen1990/rainbow'
Bundle 'flazz/vim-colorschemes'
colorscheme CandyPaper
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
let g:pymode_python = 'python3'
set laststatus=2
map <F2> :NERDTreeToggle<CR>
"Plugins
filetype plugin indent on

" execute pathogen#infect()
syntax on
set history=1000

if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
      au!
      " For all text files set 'textwidth' to 120 characters.
      autocmd FileType text setlocal textwidth=120
  augroup END

  augroup vimrc_autocmds
	autocmd!
	" highlight characters past column 110
	autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
        autocmd FileType python match Excess /\%110v.*/
        autocmd FileType python set nowrap
  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
if has('syntax') && has('eval')
  packadd matchit
endif

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    " To disable this, add the following to your .vimrc.before.local file:
    "   let g:spf13_no_restore_cursor = 1
        function! ResCur()
            if line("'\"") <= line("$")
                silent! normal! g`"
                return 1
            endif
        endfunction

        augroup resCur
            autocmd!
            autocmd BufWinEnter * call ResCur()
        augroup END

set backspace=indent,eol,start  " Backspace for dummies
set relativenumber                      " Line numbers on
highlight LineNr ctermfg=grey
set showmatch                   " Show matching brackets/parenthesis
set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
highlight clear LineNr          " Current line number row will have same background color in relative mode
highlight clear SignColumn      " SignColumn should match background
set clipboard=unnamedplus
let g:pymode_options_max_line_length = 110
set foldlevel=1
"highlight Folded guibg=#9c86a8 guifg=blue
inoremap jj <ESC>
inoremap jxx <ESC>:x<CR>
inoremap jww <ESC>:w<CR>
inoremap j4j <ESC>$
inoremap <C-Enter> <ESC>
cabbr <expr> %% expand('%:p:h')
com! FormatJSON %!python -m json.tool

