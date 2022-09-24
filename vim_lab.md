# Ⅱ. VIM Labs

1. 完成 vimtutor。 备注：它在一个 80x24（80 列，24 行） 终端窗口看起来效果最好。
    ```shell
    $ vimtutor
    ```
2. 下载我们提供的 [vimrc](https://missing-semester-cn.github.io/2020/files/vimrc)，然后把它保存到 ~/.vimrc。 通读这个注释详细的文件 （用 Vim!）， 然后观察 Vim 在这个新的设置下看起来和使用起来有哪些细微的区别。
    ```shell
    $ wget https://missing-semester-cn.github.io/2020/files/vimrc
    $ mv vimrc .vimrc
    $ cat ./.vimrc
3. 安装和配置一个插件： [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim).
    ```shell
    $ mkdir -p ~/.vim/pack/vendor/start
    $ cd ~/.vim/pack/vendor/start
    $ git clone https://github.com/ctrlpvim/ctrlp.vim
    ```
    <img src="/img/ctrlp.png">
4. 自定义 CtrlP： 添加 configuration 到你的 `~/.vimrc` 来用按 `Ctrl-P` 打开 CtrlP
5. 进一步自定义你的 `~/.vimrc` 和安装更多插件。 安装插件最简单的方法是使用 Vim 的包管理器，即使用 vim-plug 安装插件：
    ```shell
     $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```
