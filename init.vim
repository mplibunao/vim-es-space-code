syntax on

set noerrorbells
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab " always use spaces instead of tab characters
set smartindent
set smartcase
set noswapfile
set incsearch
set timeoutlen=100
set smarttab
set cindent

"--------------------------------------------------

" Automatically install Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'mbbill/undotree'
Plug 'liuchengxu/vim-which-key'
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'https://github.com/tomasiser/vim-code-dark.git'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

call plug#end()

colorscheme codedark
set background=dark

"--------------------------------------------------
source $HOME/.config/nvim/modules/coc.vim
source $HOME/.config/nvim/modules/nerdtree.vim

" rg make it search from the root directory (think)
if executable('rg')
  let g:rg_derive_root='true'
endif

" ctrl p make it ignore files in .gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let mapleader = " "
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsiz = 25

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')


" Toggle line numbers
function! ChangeLineNumbering()
if &number == 0 && &relativenumber == 0
    setlocal number!
    echo "nu:1/rnu:0"
elseif &number == 1 && &relativenumber == 0
    setlocal relativenumber!
    echo "nu:1/rnu:1"
elseif &number == 1 && &relativenumber == 1
    setlocal number!
    echo "nu:0/rnu:1"
else
    setlocal relativenumber!
    echo "nu:0/rnu:0"
endif
endfunction


" Which key config
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_map = {}

" single mappings
" search
nnoremap <leader>/ :Rg<SPACE>
" comment
let g:which_key_map[';'] = ['<plug>NERDCommenterToggle', 'comment']
" navigate to windows using space + window number

nnoremap <space>1 1<C-w>w
nnoremap <space>2 2<C-w>w
nnoremap <space>3 3<C-w>w
nnoremap <space>4 4<C-w>w
nnoremap <space>5 5<C-w>w
nnoremap <space>6 6<C-w>w
nnoremap <space>7 7<C-w>w
nnoremap <space>8 8<C-w>w
nnoremap <space>9 9<C-w>w
let g:which_key_map['1'] = 'which_key_ignore'
let g:which_key_map['2'] = 'which_key_ignore'
let g:which_key_map['3'] = 'which_key_ignore'
let g:which_key_map['4'] = 'which_key_ignore'
let g:which_key_map['5'] = 'which_key_ignore'
let g:which_key_map['6'] = 'which_key_ignore'
let g:which_key_map['7'] = 'which_key_ignore'
let g:which_key_map['8'] = 'which_key_ignore'
let g:which_key_map['9'] = 'which_key_ignore'

" p is for project
let g:which_key_map.p = {
  \ 'name': '+project',
  \ 'f': ['<C-p>', 'open file<C-p>'],
  \ 't': ['NERDTreeToggle<CR>', 'open file tree<C-b>']
\ } 

" s is for show 
let g:which_key_map.s = {
  \ 'name': '+show',
  \ 'd': [':call <SID>show_documentation()<CR>', 'documentation'],
  \ 'f': ["CocAction('fold', <f-args>)", 'fold']
\ }

" t is for toggle
let g:which_key_map.t = {
  \ 'name': '+toggle',
  \ 'l': ['ChangeLineNumbering()', 'line number']
\ }

" g is for git 
" c is for coc
let g:which_key_map.c = {
  \ 'name': '+coc',
  \ 'd': ['<Plug>(coc-definition)', 'go to definition(gd)'],
  \ 't': ['<Plug>(coc-type-definition)', 'type definition'],
  \ 'i': ['<Plug>(coc-implementation)', 'implementation'],
  \ 'r': ['<Plug>(coc-references)', 'references'],
  \ 'n': ['<Plug>(coc-diagnostic-prev)', 'next diagnostic'],
  \ 'p': ['<Plug>(coc-diagnostic-next)', 'previous diagnostic'],
  \ 'l': ['<C-u>CocList diagnostics<cr>', 'show all diagnostics'],
  \ 'e': ['<C-u>CocList extensions<cr>', 'manage extensions'],
  \ 'c': ['<C-u>CocList commands<cr>', 'show commands'],
  \ 'o': ['<C-u>CocList outline<cr>', 'find symbol of current document'],
  \ 's': ['<C-u>CocList -I symbols<cr>', 'search workspace symbols'],
  \ 'N': ['<C-u>CocNext<CR>', 'do default action for next item'],
  \ 'P': ['<C-u>CocPrev<CR>', 'do default action for previous item'],
  \ 'L': ['<C-u>CocListResume<CR>', 'resume latest coc list']
\ }

" r is for refactor
let g:which_key_map.r = {
  \ 'name': '+refactor',
  \ 'r': ['<Plug>(coc-rename)', 'rename(f2)'],
  \ 'i': ["CocAction('runCommand', 'editor.action.organizeImport')", 'organize imports'],
  \ 'p': {
      \ 'name': '+prettier',
      \ 'f': [':CocCommand prettier.formatFile', 'format file (:Prettier)'],
      \ 's': ['<Plug>(coc-format-selected)', 'format selected region'],
      \ 'b': ["CocAction('format')", 'format buffer'],
  \ },
  \ 'f': {
      \ 'name': '+fix',
      \ 's': ['<Plug>(coc-codeaction-selected)', 'refactor selected'],
      \ 'l': ['<Plug>(coc-codeaction)', 'refactor line'],
      \ 'a': ['<Plug>(coc-fix-current)', 'automatically fix current line']
  \ },
\ }


" w is for window 
let g:which_key_map.w = {
  \ 'd': [':q', 'quit'],
  \ '/': [':vsplit', 'split window right'],
  \ '-': [':split', 'split window below']
\ }



call which_key#register('<Space>', "g:which_key_map")


