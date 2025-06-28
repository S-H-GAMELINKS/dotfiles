vim9script

if has('termguicolors')
  set termguicolors
endif

syntax enable

# 行番号を表示する
set number

# bashを使うように設定
set shell=/usr/bin/bash

# カーソルの色を変更
set cursorline

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

# vim-fugitive
Plug 'tpope/vim-fugitive'

# vim-flog
Plug 'rbong/vim-flog'

# memolist.vim
Plug 'glidenote/memolist.vim'

# autosuggest.vim
Plug 'girishji/autosuggest.vim'

var options = {
    search: {
        enable: true,   # 'false' will disable search completion
        pum: true,      # 'false' for flat menu, 'true' for stacked menu
        maxheight: 12,  # max height of stacked menu in lines
        fuzzy: true,    # fuzzy completion
        alwayson: true, # when 'false' press <tab> to open popup menu
    },
    cmd: {
        enable: true,   # 'false' will disable command completion
        pum: true,      # 'false' for flat menu, 'true' for stacked menu
        fuzzy: true,    # fuzzy completion
        exclude: [],    # patterns to exclude from command completion (use \c for ignorecase)
        onspace: [],    # show popup menu when cursor is in front of space (ex. :buffer<space>)
    }
}

autocmd VimEnter * g:AutoSuggestSetup(options)

# Fern
Plug 'lambdalisue/fern.vim'

def OnVimEnter()
  timer_start(10, (_) => execute('Fern . -drawer -reveal=%'))
enddef

autocmd VimEnter * OnVimEnter()

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

# vim-obsession
Plug 'tpope/vim-obsession'

# NOTE:
# vim-fernでのファイラーがセッション復元時にエラーになるためBufferをセッションに保存しない
# メモなどは別途memolist.vimに残すこと
set sessionoptions-=buffers
g:obsession_no_buffers = 1

call plug#end()

#set runtimepath^=/home/sh/coc-typeprof

command! -nargs=* ClaudeCode :terminal claude <args>
