vim9script

if has('termguicolors')
  set termguicolors
endif

syntax enable

# インデント関連の設定
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent

# 行番号を表示する
set number

# bashを使うように設定
set shell=/usr/bin/bash

# カーソルの色を変更
set cursorline

# Vimのあいまい検索を有効化
set wildoptions+=fuzzy

# 検索時に最後まで検索すると最初のマッチするものに戻る
set wrapscan

# 別タブなどで編集されたファイルを自動で再読み込みする
set autoread

# 改行した時にインデントを調整する
set smartindent

# 前の行のインデントを維持する
set autoindent

# クリップボードの内容を別のところに張り付ける
set clipboard=unnamedplus

# コマンドの補完
set wildmenu wildmode=list:longest,full

# シンタックスハイライトを有効にする
syntax on

# バックスペースでの削除が効かなくなる対応
set backspace=indent,eol,start

# ソースコード内のインクリメンタルサーチとマッチした個所すべてのハイライト機能を有効にする
set incsearch
set hlsearch

# 連続でインデント調整ができる設定
vnoremap < <gv
vnoremap > >gv

# ctrl + -> または ctrl + <-でタブの切り替えができるようにするキーバインド
# ターミナルモードの場合
tnoremap <Esc>[1;5C <C-\><C-n>:tabnext<CR>
tnoremap <Esc>[1;5D <C-\><C-n>:tabprevious<CR>

# 通常のファイルの場合
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

# カラースキーマの設定
colorscheme slate

# vim-plug でのプラグイン導入
call plug#begin()

# fzf.vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

# vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
g:airline_theme = 'raven'
g:airline#extensions#searchcount#enabled = 0

# mru.vim
Plug 'yegappan/mru'

# previm for markdown preview
Plug 'previm/previm'
g:previm_open_cmd = 'firefox'

# coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

hi CocMenuSel ctermbg = grey ctermfg = black
hi CocSearch ctermfg = black

# coc.nvimでのtab補完の設定
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<TAB>"

#coc.nvim(Definition) ' df'で確認
nmap <silent> <space>df <Plug>(coc-definition)
#coc.nvim(References) ' rf'で確認
nmap <silent> <space>rf <Plug>(coc-references)
#coc.nvim(Rename) ' rn'で実行
nmap <silent> <space>rn <Plug>(coc-rename)
#coc.nvim(TypeDefinition) ' dt'で確認
nmap <silent> <space>dt <Plug>(coc-type-definition)
#coc.nvim(Format) ' fmt'で実行
nmap <silent> <space>fmt <Plug>(coc-format)
#coc.nvimで(Hover) ' dh'で実行
nnoremap <silent> <space>dh :call CocActionAsync('doHover')<CR>
#coc.nvimでLSPの指摘箇所に遷移 ' dn'
nmap <silent> <space>dn <Plug>(coc-diagnostic-next)
#coc.nvimで前の指摘箇所に遷移 ' dp'で実行
nmap <silent> <space>dp <Plug>(coc-diagnostic-prev)

# vim-fugitive
Plug 'tpope/vim-fugitive'

# vim-flog
Plug 'rbong/vim-flog'

# memolist.vim
Plug 'glidenote/memolist.vim'

# vimsuggest
Plug 'girishji/vimsuggest'

var vim_suggest = {}

vim_suggest.cmd = {
  'enable': v:true,
  'pum': v:true,
  'exclude': [],
  'onspace': ['b\%[uffer]', 'colo\%[rscheme]'],
  'alwayson': v:true,
  'popupattrs': {},
  'wildignore': v:true,
  'addons': v:true,
  'trigger': 't',
  'reverse': v:false,
  'prefixlen': 1,
}

vim_suggest.search = {
  'enable': v:true,
  'fuzzy': v:true,
  'pum': v:true,
  'alwayson': v:true,
}

# Fern
Plug 'lambdalisue/fern.vim'

g:fern#default_hidden = 1

nnoremap <silent> <C-n> :Fern . -drawer -toggle -reveal=%<CR>

# nerdfont for fern
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/nerdfont.vim'

g:fern#renderer = 'nerdfont'

# preview for fern
Plug 'yuki-yano/fern-preview.vim'

# fern-preview のキーバインド
def SetupFernPreview()
  nnoremap <buffer><silent> p       <Plug>(fern-action-preview:toggle)
  nnoremap <buffer><silent> <C-d>   <Plug>(fern-action-preview:scroll:down:half)
  nnoremap <buffer><silent> <C-u>   <Plug>(fern-action-preview:scroll:up:half)
enddef

autocmd FileType fern SetupFernPreview()

# vim-gitgutter
Plug 'airblade/vim-gitgutter'

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

# vim-better-whitespace
Plug 'ntpeters/vim-better-whitespace'

# vim-sandwich
Plug 'machakann/vim-sandwich'

# vim-commentary
Plug 'tpope/vim-commentary'

# TypeProf LSP for coc.nvim
Plug 'S-H-GAMELINKS/coc-typeprof'
#set runtimepath^=/home/sh/coc-typeprof

# Kanayago LSP for coc.nvim
Plug 'S-H-GAMELINKS/coc-kanayago'
#set runtimepath^=/home/sh/oss/kanayago_dev/coc-kanayago

# vim-test
Plug 'vim-test/vim-test'

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

# vim-localvimrc
Plug 'embear/vim-localvimrc'

g:localvimrc_name = ['.lvimrc']
g:localvimrc_ask = 1
g:localvimrc_sandbox = 1
g:localvimrc_whitelist = [expand('~/rubydev/ruby/.lvimrc')]

call plug#end()
