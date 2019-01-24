#!/data/data/com.termux/files/usr/bin/bash

export PREFIX=${PREFIX:-/data/data/com.termux/files/usr}
export PATH=$PREFIX/bin:$PATH

echo "==> 修改 motd ..."
cat > $PREFIX/etc/motd <<EOF
Yes,sir! Welcome to Termux!
EOF

echo "==> 使用 TUNA 镜像 ..."
MIRROR=https://mirrors.tuna.tsinghua.edu.cn/termux
cat > $PREFIX/etc/apt/sources.list <<EOF
# The main tremux repository:
#deb https://termux.net stable main
deb [arch=all,$(uname -m)] $MIRROR stable main
EOF
pkg update

echo "==> 安装软件 ..."
pkg install curl git gnupg htop openssh proot python vim-python zsh screenfetch

echo "==> 配置 git ..."
cat >$HOME/.gitconfig <<'EOF'
[alias]
    ci = commit
    st = status
    co = checkout
    br = branch
    lg = log -p
    stage = add
    unstage = reset HEAD
    plog = log --pretty=tformat:'%h %Cblue%cr%Creset %cn %Cgreen%s%Creset'
    graph = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --all
    timmeh = commit -am'TIMMEH\\!'
    subs = submodule foreach git pull origin master¬
    local = log --numstat --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --first-parent --no-merges
    ls = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate
    ll = log --numstat --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate
[color]
    ui = auto
[color "branch"]
    current = yellow reverse
    local = yellow
    remote = green
[color "diff"]
    meta = yellow bold
    frag = magenta bold
    old = red bold
    new = green bold
[color "status"]
    added = yellow
    changed = green
    untracked = cyan
[push]
    default = current
[core]
    editor = vim
EOF

echo "==> 配置 ssh ..."
ssh-keygen
cat >$HOME/.ssh/config <<EOF
Host *
    Protocol 2
    IdentityFile ~/.ssh/id_rsa
    ServerAliveInterval 60
EOF

echo "==> 配置 python ..."
mkdir $HOME/.pip
cat >$HOME/.pip/pip.conf <<EOF
[global]
timeout = 60
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
EOF
pip install ipython you-get

echo "==> 配置 vim ..."
cat >$HOME/.vimrc <<EOF
set nu! "显示行号
set fenc=utf-8 "设定默认解码
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936
set nocompatible "不要使用vi的键盘模式,而是vim自己的
set ruler "开启右下角光标位置显示
set cursorline "高亮光标所在行
set hlsearch "搜索关键词高亮
set confirm "在处理未保存或只读文件的时候,弹出确认
set foldmethod=marker "代码折叠
set backup "修改文件时备份
set noswapfile "不要缓存
set autoindent "自动缩进,继承前一行的缩进方式,特别适用于多行注释
set expandtab "在缩进和遇到Tab键时使用空格 替代;使用noexpandtab取消设置
set shiftwidth=4 "缩进的空格数
set tabstop=4 "制表符的宽度,等于几个空格
colorscheme desert "主题
syntax on "语法高亮
filetype plugin indent on "侦测文件类型，载入文件类型plugin脚本，使用缩进定义文件
" 自动补全配置
set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	"回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
EOF

echo "==> 配置 zsh ..."
sh -c "$(curl -fsSL https://github.com/Cabbagec/termux-ohmyzsh/raw/master/install.sh)"

rm -rf $HOME/termux-ohmyzsh/
rm -rf $HOME/.cache/
echo "==> Done."
