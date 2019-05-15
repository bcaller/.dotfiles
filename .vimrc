" bcaller's vimrc
"
" Many settings from
" https://github.com/spf13/spf13-vim/blob/1ce5f23997f6dd82235c6936c5c47b3f1d1b4e50/.vimrc.bundles
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
Bundle 'VundleVim/Vundle.vim'
if !has('nvim')
	Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
endif
"powerline-status is bad python version
"set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
Bundle 'tpope/vim-fugitive'
"Bundle 'scrooloose/nerdtree'
Bundle 'klen/python-mode'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
" not used, conflicts with C-N Bundle 'terryma/vim-multiple-cursors'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'gcmt/wildfire.vim'
Bundle 'tpope/vim-commentary'
if !has('nvim')
	Bundle 'airblade/vim-gitgutter'
endif
Bundle 'luochen1990/rainbow'
Bundle 'flazz/vim-colorschemes'
Bundle 'easymotion/vim-easymotion'
Bundle 'ConradIrwin/vim-bracketed-paste'
Bundle 'tmux-plugins/vim-tmux'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tommcdo/vim-fugitive-blame-ext'
Bundle 'tpope/vim-abolish'
Bundle 'kshenoy/vim-signature'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'bkad/CamelCaseMotion'
Bundle 'Shougo/vimproc'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'gabrielelana/vim-markdown'
Bundle 'rust-lang/rust.vim'
Bundle 'godlygeek/tabular'
Bundle 'maksimr/vim-jsbeautify'
colorscheme CandyPaper
set background=dark
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
let g:pymode_python = 'python3'
set laststatus=2
map <F2> :NERDTreeToggle<CR>
"Plugins
filetype plugin indent on
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

syntax on
set history=1000

if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
if !has('nvim')
	source $VIMRUNTIME/defaults.vim
endif

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
  set t_Co=256
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
	autocmd FileType python nnoremap fff :let @f='<C-r><C-w>'<CR>/def <C-r>f(<CR>zt<ESC>
	autocmd FileType python nnoremap <Leader>tt :w<CR>:call Pytest()<CR>
	autocmd FileType haskell set shiftwidth=2
	autocmd FileType haskell set expandtab
	autocmd FileType htmldjango set shiftwidth=2
	autocmd FileType htmldjango set expandtab
	autocmd FileType capnp set shiftwidth=4
	autocmd FileType capnp set tabstop=4
	autocmd FileType capnp set expandtab
  augroup END

  autocmd CursorHold,VimResized,FocusLost * redraw!

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
if has('syntax') && has('eval') && !has('nvim')
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

let g:markdown_fenced_languages = ['html', 'python', 'js=javascript', 'bash=sh']
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
set foldlevel=2
"highlight Folded guibg=#9c86a8 guifg=blue
"quit insert mode
inoremap jj <ESC>
":x!
nnoremap s :
inoremap sxx <ESC>:wa<CR><ESC>:xa<CR>
inoremap jxx <ESC>:wa<CR><ESC>:xa<CR>
"fill word from line above
inoremap <C-k> <space><ESC>k""yEj""Pla
":w!
inoremap sww <ESC>:w<CR><ESC>:w<CR>
inoremap jww <ESC>:w<CR><ESC>:w<CR>
"quit insert and append to end of line
inoremap s4s <ESC>A
nnoremap sww :w<CR>:w<CR>
nnoremap sxx <ESC>:wa<CR>:xa<CR>
nnoremap sqq :qa<CR>
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
nmap <Leader>gut :GitGutterToggle<CR>
nnoremap <esc>^[ <esc>^[
"unhilight search matches
noremap <silent><esc> <esc>:noh<CR><esc>
nmap <Leader>nn :noh<CR>
"swap adjacent words
nnoremap <silent> gw :s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o>:noh<CR>
" move lines up and down
nnoremap gj :m .+1<CR>==
nnoremap gk :m .-2<CR>==
inoremap KK <Esc>:m .-2<CR>==gi
inoremap JJ <Esc>:m .+1<CR>==gi
nnoremap !p o<Esc>p
nnoremap // /\c
nnoremap # *
nnoremap * #
" replace motion with paste
function! ReplaceWithPaste(type)
   let @"=@*
   silent execute 'normal! `[v`]d"0P'
endfunction
nnoremap sp :set opfunc=ReplaceWithPaste<CR>g@
" replace the.big.dog attribute with the['big'].dog index when cursor over dot after the
nmap cai hf.xysw]lysw'
nmap cia hf[i.<Esc>2lx:norm f<C-r>"<CR>xds]
"open file search
set wildignorecase
set wildignore+=*.a,*.o
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp,*.pyc,*.un,.env
nmap <C-N> :e **/
nmap <C-N><C-N> :e %%/**/
" Camel Snake
map <silent> ,w <Plug>CamelCaseMotion_w
map <silent> ,b <Plug>CamelCaseMotion_b
map <silent> ,e <Plug>CamelCaseMotion_e
omap <silent> i,w <Plug>CamelCaseMotion_iw
xmap <silent> i,w <Plug>CamelCaseMotion_iw
set diffopt=vertical
if !has('nvim')
	set ttymouse=sgr
endif
set mouse=nicr
set tildeop
