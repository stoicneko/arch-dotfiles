# Fish 基本设置
set -g fish_greeting ""

# 环境变量
set -gx EDITOR nvim # 默认编辑器
set -gx LANG en_US.UTF-8 # 语言环境 这个会导致整个系统显示英文(gnome)
# 下面这两行配置终端显示英文
# set -gx LC_MESSAGES en_US.UTF-8
# set -gx LC_CTYPE en_US.UTF-8

set -gx XDG_CONFIG_HOME $HOME/.config # XDG 配置目录
set -gx XDG_DATA_HOME $HOME/.local/share # XDG 数据目录
set -gx XDG_CACHE_HOME $HOME/.cache # XDG 缓存目录
set -gx PATH ~/.local/bin $PATH # 用户本地二进制目录

set -gx aurhelper paru
# 全局函数
function upd -d "Git pull, add all, commit with 'update', and push"
    git pull
    git add --all
    git commit -m update
    git push
end

# 交互式会话配置
if status is-interactive
    fish_vi_key_bindings # 启用 vi 模式按键绑定

    # 代理
    # alias proxy 'export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890'
    # alias unproxy 'unset all_proxy'
    # 目录导航
    alias jj "cd .."
    alias .. 'cd ..'
    alias .2 'cd ../..'
    alias .3 'cd ../../..'
    alias .4 'cd ../../../..'
    alias .5 'cd ../../../../..'
    # 编辑器和配置文件
    alias vi nvim
    # alias v nvim
    alias t tmux
    alias v '~/.local/share/bin/auto_padding_nvim.sh'
    alias nvim '~/.local/share/bin/auto_padding_nvim.sh'

    alias cfish "nvim $HOME/.config/fish/config.fish"
    alias sfish "source $HOME/.config/fish/config.fish"
    alias cyazi "nvim $HOME/.config/yazi/keymap.toml"

    alias tree "exa -T"

    # 适用于linux/mac, 退出终端仍能neovide不退出
    # neovide config
    function nv
        nohup neovide &
    end
    # alias nv 'neovide.exe'

    # alias vf "nvim $(fzf)"
    function vf
        nvim $(fzf)
    end

    alias op xdg-open
    alias l "eza -lh --icons=auto" # long list
    alias ls "eza -1 --icons=auto" # short list
    alias ll "eza -lha --icons=auto --sort=name --group-directories-first" # long list all
    alias ld "eza -lhD --icons=auto" # long list dirs
    alias lt "eza --icons=auto --tree" # list folder as tree

    alias un "$aurhelper -Rns" # uninstall package
    alias up "$aurhelper -Syu" # update system/package/aur
    alias pf "$aurhelper -Qs" # list installed package
    alias ps "$aurhelper -Ss" # search available package
    alias pi "$aurhelper -S" # install package
    alias pc "$aurhelper -Sc" # remove unused cache
    alias po "$aurhelper -Qtdq | $aurhelper -Rns -" # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -

    # 终端操作
    abbr :q exit
    abbr b btop
    abbr fa fastfetch
    abbr m musicfox

    # Git 相关
    abbr gcl "git clone"
    abbr gs "git status"
    abbr ga "git add"
    abbr gaa "git add --all"
    abbr gc "git commit"
    abbr gac "git commit -am"
    abbr gps "git push"
    abbr gpl "git pull"
    abbr gsi "git submodule init"
    abbr gsu "git submodule update --recursive --remote"
    abbr lg lazygit

    function gitlog -d "Git log with custom format"
        git log --all --graph --pretty=format:"%Cred%h%Creset %C(bold blue)%an%Creset %s %Cgreen(%cr) %Creset" --abbrev-commit $argv
    end

    # 外部工具初始化
    zoxide init fish | source
    starship init fish | source

    # 打开fish默认启用tmux
    # and not set -q TMUX
    # tmux attach-session -t main; or tmux new-session -s main
end

# 自定义函数
function j -d "Jump to directory with zoxide or cd"
    if test (count $argv) -eq 0
        z
    else if test "$argv[1]" = -
        z $argv
    else
        cd $argv 2>/dev/null || z $argv
    end
end

function a -d "Run yazi and change to its last directory"
    set tmp (mktemp -t "yazi-cwd.XXXXX")
    yazi --cwd-file="$tmp"
    if set cwd (command cat "$tmp"); and test -n "$cwd" -a "$cwd" != "$PWD"
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
