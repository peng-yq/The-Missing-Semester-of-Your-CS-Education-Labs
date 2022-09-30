# Ⅴ. Git Labs
1. 如果您之前从来没有用过 Git，推荐您阅读 [Pro Git](https://git-scm.com/book/en/v2) 的前几章，或者完成像 [Learn Git Branching](https://learngitbranching.js.org/)这样的教程。重点关注 Git 命令和数据模型相关内容；
2. Fork 本课程网站的仓库
3. 将版本历史可视化并进行探索
    ```shell
    git clone https://github.com/peng-yq/missing-semester.git ~/missing_semester
    cd missing_semester
    git log --all --graph --decorate
    ```
4. 是谁最后修改了 README.md文件？（提示：使用 `git log` 命令并添加合适的参数）
    ```shell
    git log README.md
    ```
    <img src="/images/readme.png">

    > 最后修改README.md的作者是Anish Athalye
5. 最后一次修改_config.yml 文件中 collections: 行时的提交信息是什么？（提示：使用 `git blame` 和 `git show`）
    ```shell
    git blame _config.yml
    git show a88b4ea
    ```
    <img src="/images/collections.png">

    > 提交信息为Redo lectures as a collection
6. 使用 Git 时的一个常见错误是提交本不应该由 Git 管理的大文件，或是将含有敏感信息的文件提交给 Git 。尝试向仓库中添加一个文件并添加提交信息，然后将其从历史中删除 ( [这篇文章也许会有帮助](https://help.github.com/articles/removing-sensitive-data-from-a-repository/))；
    ```shell
    echo "password" > password.txt
    git add .
    git commit -m "add password"
    git log
    git filter-branch --force --index-filter\
    'git rm --cached --ignore-unmatch ./password.txt'\ --prune-empty --tag-name-filter cat -- --all
    ls
    git log
    ```
7. 从 GitHub 上克隆某个仓库，修改一些文件。当您使用 `git stash` 会发生什么？当您执行 `git log --all --oneline` 时会显示什么？通过 `git stash pop` 命令来撤销 `git stash` 操作，什么时候会用到这一技巧？
    >[git stash 介绍和教程](https://blog.csdn.net/daguanjia11/article/details/73810577)
    ```shell
    vim 404.html
    git stash
    git log --all --oneline
    git stash pop
    ```
    <img src="/images/git_stash.png">

    > 我们有时会遇到这样的情况，正在dev分支开发新功能，做到一半时有人过来反馈一个bug，让马上解决，但是新功能做到了一半你又不想提交，这时就可以使用git stash命令先把当前进度保存起来，然后切换到另一个分支去修改bug，修改完提交后，再切回dev分支，使用git stash pop来恢复之前的进度继续开发新功能。
8. 与其他的命令行工具一样，Git 也提供了一个名为 ~/.gitconfig 配置文件 (或 dotfile)。请在 ~/.gitconfig 中创建一个别名，使您在运行 `git graph` 时，您可以得到 `git log --all --graph --decorate --oneline` 的输出结果；
    ```shell
    git config --global alias.graph "log --all --graph --decorate --oneline"
    git graph
    ```
9. 您可以通过执行 `git config --global core.excludesfile ~/.gitignore_global` 在 `~/.gitignore_global` 中创建全局忽略规则。配置您的全局 gitignore 文件来自动忽略系统或编辑器的临时文件，例如 .DS_Store；
    ```shell
    git config --global core.excludesfile ~/.gitignore_global
    echo ".DS_Store" > ~/.gitignore_global
    ```
10. 克隆 [本课程网站的仓库](https://github.com/missing-semester/missing-semester)，找找有没有错别字或其他可以改进的地方，在 GitHub 上发起拉取请求（Pull Request）；