" neobundle settings {{{
if has('vim_starting')
  set nocompatible
  " neobundle をインストールしていない場合は自動インストール
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  " runtimepath の追加は必須
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'


NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'nanotech/jellybeans.vim'

" vimrc に記述されたプラグインでインストールされていないものがないかチェックする
NeoBundleCheck
call neobundle#end()
filetype plugin indent on
set t_Co=256
syntax on
colorscheme jellybeans



" ターミナルの右端で文字を折り返さない
set nowrap

" tempファイルを作らない。編集中に電源落ちまくるし、とかいう人はコメントアウトで
set noswapfile

" ハイライトサーチを有効にする。文字列検索は /word とか * ね
set hlsearch
" 大文字小文字を区別しない(検索時)
set ignorecase
" ただし大文字を含んでいた場合は大文字小文字を区別する(検索時)
set smartcase

" カーソル位置が右下に表示される
set ruler
" 行番号を付ける
set number
" タブ文字の表示 ^I で表示されるよ
"set list
" コマンドライン補完が強力になる
set wildmenu
" コマンドを画面の最下部に表示する
set showcmd
" クリップボードを共有する(設定しないとvimとのコピペが面倒です)
set clipboard=unnamed

" 改行時にインデントを引き継いで改行する
set autoindent
" インデントにつかわれる空白の数
set shiftwidth=4
" <Tab>押下時の空白数
set softtabstop=4
" <Tab>押下時に<Tab>ではなく、ホワイトスペースを挿入する
set expandtab
" <Tab>が対応する空白の数
set tabstop=4

" インクリメント、デクリメントを16進数にする(0x0とかにしなければ10進数です。007をインクリメントすると010になるのはデフォルト設定が8進数のため)
set nf=hex
" マウス使えます
set mouse=a

set clipboard=unnamed,autoselect

" インサートモードの時に C-j でノーマルモードに戻る
imap <C-j> <esc>
" [ って打ったら [] って入力されてしかも括弧の中にいる(以下同様)
imap [ []<left>
imap ( ()<left>
imap { {}<left>

" ２回esc を押したら検索のハイライトをヤメる
nmap <Esc><Esc> :nohlsearch<CR><Esc>
