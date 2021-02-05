# dotfiles

## [zsh環境設定]
sh dotfilesLink.sh init  
sh dotfilesLink.sh deploy  
  
## [perl環境設定]
dotfilesLinsk.shからPerl関連は外しました

plenv install 5.25.6  
plenv global 5.25.6  
plenv install-cpanm  
plenv exec cpanm Module::Install  
plenv exec cpanm Carton  
echo "requires 'Task::Plack';" > cpanfile  
plenv exec carton install  
plenv rehash  
->5.25.6でcarton通らない場合は18.2あたりに下げる  
