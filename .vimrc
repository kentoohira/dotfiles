" 基本操作メモ (忘れがちなものピックアップ)
" Ctrl + v    visualブロックモード
" vjj         visualモードで範囲選択
" w           単語区切りで移動
" $           行末に移動
" ^           行頭に移動
" Git操作メモ (vim-fugitve))
" :Gdiff      git diff の表示
" :Git        git status のようなステータス表示
" :Git blame  git blame
" :Gwrite     git add
" :Git commit git commit
" :Git push   git push
" :Git pull   git pull
" :Gbranches  fzfを利用したブランチのcheckout
" :Git <command> :Gitの後の引数は通常のgitコマンドの引数として受け取られて処理される
" fzf操作メモ
" :Commands   コマンド一覧
" :Files      カレントディレクトリ以下のファイルの曖昧検索
" :GFiles     gitファイル曖昧検索
" :History    過去開いたファイルの曖昧検索
" :History:   過去実行したvimコマンドの曖昧検索
" :Commits    commit log 確認(require fugitive.vim))
" ショートカット設定まとめ
" Ctrl + ]    fzfによるブランチチェックアウト
" Ctrl + e    NerdTreeによるエクスプローラ表示。デフォルトで隠しファイル表示。Shift + iで切り替え
" Ctrl + b    タブ移動
" Ctrl + n    タブ移動
" Ctrl + k    コメントアウト
" vjj gcc     複数行をまとめてコメントアウト
" ga =        EasyAlignを起動して、= でアライン
" Lsp周り
" :LspInstallServeri LspServerのインストール
" :LspMangaServer    LaunguageServer一覧表示と管理


" color
if empty(glob('~/.vim/colors/jellybeans.vim'))
  silent !curl -fLo ~/.vim/colors/jellybeans.vim --create-dirs
    \ https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
    \ >/dev/null 2>&1
endif
colorscheme jellybeans
let g:jellybeans_overrides = {
\    'Todo': { 'guifg': '303030', 'guibg': 'f0f000',
\              'ctermfg': 'Black', 'ctermbg': 'Yellow',
\              'attr': 'bold' },
\    'Comment': { 'guifg': 'cccccc' },
\}

syntax enable

set encoding=utf-8
set fileencodings=utf-8,cp932
set autoread
set number
set re=0
" 行頭以外のtab表示幅
set tabstop=4
" 行頭でのtab表示幅
set shiftwidth=4
set smartindent
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan
set wildmenu
set history=5000
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" 記号表記で崩れないようにする
set ambiwidth=double

" airline利用しない場合は以下コメントアウトを外してステータスラインをカスタマイズ
""ファイル名表示
" set statusline=%F
" 変更チェック表示
" set statusline+=%m
" 読み込み専用かどうか表示
" set statusline+=%r
" " ヘルプページなら[HELP]と表示
" set statusline+=%h
" " プレビューウインドウなら[Preview]と表示
" set statusline+=%w
" " これ以降は右寄せ表示
" set statusline+=%=
" " file encoding
" set statusline+=[enc=%{&fileencoding}]
" " 現在行数/全行数
" set statusline+=[row=%l/%L]
" " 現在列数
" set statusline+=[col=%c]
""ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
" set laststatus=2

" undo 永続化
silent !mkdir ~/.vim/undo -p >/dev/null 2>&1
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

" 補完
inoremap ( ()<LEFT>
" inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap { {}<LEFT>
inoremap < <><LEFT>
" 自動インデント
inoremap {<Enter> {}<Left><CR><CR><BS><Up><Right>

" To use fzf in Vim, add the following line to your .vimrc:
set rtp+=/usr/local/opt/fzf

" vim-plug
" install vim-plug if not exists
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" auto install plugin
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC

call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-easy-align'
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter' " gitの追加/削除/変更 行の表示
Plug 'mhinz/vim-signify'
" Ctrl + p でファイル・バッファをあいまい検索
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jmcantrell/vim-virtualenv'
" (caw.vimに移行したので利用していない)通常モードでgcc, Visualモードでgcでコメントアウト
" Plug 'tomtom/tcomment_vim'
Plug 'tyru/caw.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
" lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
" auto-complete
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" fzf-checkout.vim オプション
" Sort branches/tags by committer date. Minus sign to show in reverse order (recent first):
let g:fzf_checkout_git_options = '--sort=-committerdate'
" Define a diff action using fugitive. You can use it with :GBranches diff or with :GBranches and pressing ctrl-f:
"  Ctrl + ] でfzf-checkout
nnoremap <silent><C-]> :GBranches<CR>

" Ctrl + e でエクスプローラー表示
nnoremap <silent><C-e> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1 " 隠しファイルを表示. Shift + i で切り替え
" Ctrl + b Ctrl + n でタブ移動
nmap <C-b> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab
" Ctr + K でコメントアウト
nmap <C-k> <plug>(caw:i:toggle)
vmap <C-k> <plug>(caw:i:toggle)
" gaでEasy Align 起動(e.g. =で揃える場合はga=)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

set ttimeoutlen=50 " モード変更遅延解消

" Airline setting
" let g:airline_powerline_fonts = 1
let g:airline_theme = 'luna'   " テーマ指定
" 他テーマを指定したい場合には以下を参考にお好みのものを指定
" https://github.com/vim-airline/vim-airline/wiki/Screenshots

set t_Co=256 " この設定がないと色が正しく表示されない場合がある
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1 " タブラインを表示
let g:airline#extensions#tabline#buffer_idx_mode = 1 " タブ番号表示

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

call plug#end()
