" bcaller's vimrc
"
" Many settings from
" https://github.com/spf13/spf13-vim/blob/1ce5f23997f6dd82235c6936c5c47b3f1d1b4e50/.vimrc.bundles
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
Bundle 'VundleVim/Vundle.vim'
Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
"powerline-status is bad python version
"set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'klen/python-mode'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'gcmt/wildfire.vim'
Bundle 'tpope/vim-commentary'
Bundle 'airblade/vim-gitgutter'
Bundle 'luochen1990/rainbow'
Bundle 'flazz/vim-colorschemes'
Bundle 'easymotion/vim-easymotion'
colorscheme CandyPaper
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
let g:pymode_python = 'python3'
set laststatus=2
map <F2> :NERDTreeToggle<CR>
"Plugins
filetype plugin indent on

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
	autocmd FileType python nnoremap ( A)<ESC>I(<ESC>I
	autocmd FileType python nnoremap ( A)<ESC>I(<ESC>I
	autocmd FileType python nnoremap ) ea)<ESC>I(<ESC>I
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
set clipboard=unnamed,unnamedplus
let g:pymode_options_max_line_length = 110
let g:pymode_lint_on_write = 1
let g:pymode_rope = 0
set foldlevel=1
"highlight Folded guibg=#9c86a8 guifg=blue
"quit insert mode
inoremap jj <ESC>
":x!
inoremap sxx <ESC>:x<CR>
inoremap jxx <ESC>:x<CR>
"search backwards for prefix and autocomplete word
inoremap <C-l> <ESC>?\<<C-r><C-w>\w<CR>yw<C-o>ciw<C-r>0
"fill word from line above
inoremap <C-k> <space><ESC>kyEjPla
":w!
inoremap sww <ESC>:w<CR>
inoremap jww <ESC>:w<CR>
"quit insert and append to end of line
inoremap s4s <ESC>A
nnoremap s :
nnoremap sww :w<CR>
nnoremap sxx :x<CR>
nnoremap sqq :q<CR>
nnoremap <TAB> I<TAB><ESC>+
nnoremap <S-TAB> I<BS><ESC>+
nnoremap <C-l> a<CR><ESC>
"when searching, copy line with first match and paste here
cnoremap $y <CR>:t''<CR>
"when searching, move line with first match here
cnoremap $m <CR>:m''<CR>
cnoremap $d <CR>:d<CR>``
cnoremap <space><space> <cr>
nnoremap !! :<up><home><right>!
"press space for easy motion
map <space> <Plug>(easymotion-prefix)
nmap <space>/ <Plug>(easymotion-s2)
cabbr <expr> %% expand('%:p:h')
com! FormatJSON %!python -m json.tool
nmap <Leader>gutt :GitGutterToggle<CR>
nnoremap <esc>^[ <esc>^[
"unhilight search matches
noremap <silent><esc> <esc>:noh<CR><esc>
nmap <Leader>nn :noh<CR>
set diffopt=vertical
set ttymouse=sgr
set mouse=nicr

