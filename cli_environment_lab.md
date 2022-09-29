# Ⅳ. CLI Environment Labs
## Job control
==对jobs/processes的操作，比如Ctrl-C，Ctrl-Z，kill等都是给其发送一个signal，从而进行控制==。
1. 我们可以使用类似 `ps aux | grep` 这样的命令来获取任务的 pid ，然后您可以基于pid 来结束这些进程。但我们其实有更好的方法来做这件事。在终端中执行 `sleep 10000` 这个任务。然后用 `Ctrl-Z` 将其切换到后台并使用 `bg` 来继续允许它。现在，使用 `pgrep` 来查找 pid 并使用 `pkill` 结束进程而不需要手动输入pid。(提示：: 使用 -af 标记)。
***[pgrep，pkill使用方法](https://wker.com/linux-command/pgrep-pkill.html)***

    ```shell
    sleep 10000
    ^z
    [1]  + 13187 suspended  sleep 10000

    jobs
    [1]  + suspended  sleep 10000

    bg %1
    [1]  + 13187 continued  sleep 10000
    jobs
    [1]  + running    sleep 10000

    pgrep -f "sleep 10000"
    pkill -f "sleep 10000"
    jobs
    ```
2. 如果您希望某个进程结束后再开始另外一个进程， 应该如何实现呢？在这个练习中，我们使用 `sleep 60 &` 作为先执行的程序。一种方法是使用 [wait](https://zhuanlan.zhihu.com/p/142928638) 命令。尝试启动这个休眠命令，然后待其结束后再执行 `ls` 命令。
    ```shell
    sleep 60 &
    pgrep sleep | wait && ls 
    ```
    但是，如果我们在不同的 bash 会话中进行操作，则上述方法就不起作用了 (比如下图) 。因为 `wait` 只能对子进程起作用。之前我们没有提过的一个特性是，`kill` 命令成功退出时其状态码为 0 ，其他状态则是非0。`kill -0` 则不会发送信号，但是会在进程不存在时返回一个不为0的状态码。请编写一个 bash 函数 `pidwait` ，它接受一个 pid 作为输入参数，然后一直等待直到该进程结束。您需要使用 `sleep` 来避免浪费 `CPU` 性能。
    <img src="/images/wait.png">
    
    ```bash
    pidwait(){
        while kill -0 $1 2>/dev/null
        do
        sleep 1
        done
        ls
    }
    ```
    关于`kill -0`以及`2>/dev/null`的解释见[解答](https://unix.stackexchange.com/questions/169898/what-does-kill-0-do)。

    ```shell
    sleep 60 &
    pidwait $(pgrep sleep)
    ```
## Terminal multiplexer
关于tmux的介绍和使用可见[博客文章](https://peng-yq.github.io/2022/04/01/tmux/)
## Aliases
1. 创建一个 dc 别名，它的功能是当我们错误的将 cd 输入为 dc 时也能正确执行。
    ```shell
    alias dc=cd
    dc
    ```
2. 执行 `history | awk '{$1="";print substr($0,2)}' | sort | uniq -c | sort -n | tail -n 10` 来获取您最常用的十条命令，尝试为它们创建别名。注意：这个命令只在 Bash 中生效，如果您使用 ZSH，使用 `history 1` 替换 `history`。
    ```shell
    history 1 | awk '{$1="";print substr($0,2)}' | sort | uniq -c | sort -n | tail -n 10
         11 git add .
     11 tmux a
     13 jobs
     13 tmux
     16 ./calc-chip-cost
     16 gcc ./calc-chip-cost.c -o calc-chip-cost -lm
     18 tmux ls
     21 cd
     35 exit
    141 ls
    ```
## Dotfiles
1. 让我们帮助您进一步学习配置文件：

    - 为您的配置文件新建一个文件夹，并设置好版本控制
    - 在其中添加至少一个配置文件，比如说您的 shell，在其中包含一些自定义设置（可以从设置 $PS1 开始）。
    - 建立一种在新设备进行快速安装配置的方法（无需手动操作）。最简单的方法是写一个 shell 脚本对每个文件使用 ln -s，也可以使用专用工具
    - 在新的虚拟机上测试该安装脚本。
    - 将您现有的所有配置文件移动到项目仓库里。
    - 将项目发布到GitHub。
    >此处省略了版本管理和GitHub，并只演示了vimrc的配置，其他软件配置文件可一并参考此法
    ```shell
    mkdir ~/dotfiles
    mv ~/.vimrc ~/dotfiles/vimrc
    ```
    ```bash
    # !/bin/bash

    files="vimrc"

    for file in $files; do
        ln -s ~/dotfiles/$file ~/.$file
    done
    ```
    ```shell
    bash ./dotfile_install.sh
    ```
## Remote Machines
1. 前往 `~/.ssh/` 并查看是否已经存在 SSH 密钥对。如果不存在，请使用`ssh-keygen -o -a 100 -t ed25519`来创建一个。建议为密钥设置密码然后使用ssh-agent，更多信息可以参考[这里](https://www.ssh.com/academy/ssh/agent)；
    >*此处在本机操作，非远程主机*，一定要设置密钥（**以防自己忘记，此次设置密钥设置为用户密码**）
    ```shell
    ssh-keygen -o -a 100 -t ed25519
    ls ~/.ssh
    ```
2. 在`.ssh/config`加入下面内容
    ```shell
    Host ubuntu20.04
        User username_goes_here
        HostName ip_goes_here
        IdentityFile ~/.ssh/id_ed25519
        LocalForward 9999 localhost:8888
    ```
3. 使用 `ssh-copy-id vm`将您的 ssh 密钥拷贝到服务器。
    ```shell
    ssh-copy-id pyq@192.168.140.129
    ssh ubuntu20.04
    ```
4. 使用`python -m http.server 8888` 在您的虚拟机中启动一个 Web 服务器并通过本机的`http://localhost:9999`访问虚拟机上的 Web 服务器
    ```shell
    ssh -L 9999:localhost:8888 ubuntu20.04
    ```
    <img src="/images/python_web.png">
    
    > ps: 突然发现这种方式来下载远程主机的文件还挺方便的
5. 使用`sudo vim /etc/ssh/sshd_config` 编辑 SSH 服务器配置，通过修改PasswordAuthentication的值来禁用密码验证。通过修改PermitRootLogin的值来禁用 root 登录。然后使用`sudo service sshd restart重启 ssh` 服务器，然后重新尝试。
6. (附加题) 在虚拟机中安装 mosh 并启动连接。然后断开服务器/虚拟机的网络适配器。mosh可以恢复连接吗？
7. (附加题) 查看ssh的-N 和 -f 选项的作用，找出在后台进行端口转发的命令是什么？