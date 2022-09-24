# Ⅰ. Shell Labs

1. 本课程需要使用类Unix shell，例如 Bash 或 ZSH。如果您在 Linux 或者 MacOS 上面完成本课程的练习，则不需要做任何特殊的操作。如果您使用的是 Windows，则您不应该使用 cmd 或是 Powershell；您可以使用Windows Subsystem for Linux或者是 Linux 虚拟机。使用echo $SHELL命令可以查看您的 shell 是否满足要求。如果打印结果为/bin/bash或/usr/bin/zsh则是可以的。
    ```shell
    $ echo $SHELL
    /bin/zsh
    ```
2. 在 /tmp 下新建一个名为 missing 的文件夹。
    ```shell
    $ cd /tmp && mkdir missing
    ```
3. 用 man 查看程序 touch 的使用手册。
    ```shell
    $ man touch
    ```
4. 用 touch 在 missing 文件夹中新建一个叫 semester 的文件。
    ```shell
    $ cd missing && touch semester
    $ ls
    semester
    ```
5. 将以下内容一行一行地写入 semester 文件：
    ```shell
    #!/bin/sh
    curl --head --silent https://missing.csail.mit.edu
    ```
    ```shell
    $ vim semester
    $ cat semester
    #!/bin/sh
    curl --head --silent https://missing.csail.mit.edu
    ```
6. 尝试执行这个文件。例如，将该脚本的路径（./semester）输入到您的shell中并回车。如果程序无法执行，请使用 ls 命令来获取信息并理解其不能执行的原因。
    ```shell
    $ ./semester
    zsh: permission denied: ./semester
    $ ls -l
    total 4
    -rw-r--r-- 1 pyq-ubuntu pyq-ubuntu 63 Sep 24 10:36 semester
    ```
    > 通过`ls`命令可以看到此处无法执行是因为user没有`x`（执行）权限。

    对`total 4`进行简单解释：
    - `total 4`：total后面的数字是指当前目录下所有文件所占用的空间总和，即`4KB`。
    - Linux中通过page来存储和管理文件，并且**一个page只能容纳一个文件，而一个文件可以存在多个page上（比如一个文件的大小大于一个page的大小）**。
    - Linux中page的大小通常是`4KB`，也可以通过`getconf PAGESIZE`命令查看当前系统的pagesize。
    - 回到这个文件夹下，由于只有一个文件，因此只有一个page，即`4KB`，所以total后面显示4。

    `-rw-r--r--`：第一个字符表示当前文件的类型：d表示目录，-表示文件，l表示链接文件，c表示U盘鼠标等一次性读取设备；从第二个字符到最后分别表示user，user-group，others的**读写执行**权限，是Linux访问控制的体现。

    `1`：链接数，表示有多少个文件链接到inode_num。

    `pyq-ubuntu pyq-ubuntu`：文件拥有者，所属group。

    `63`：文件大小，字节为单位，即63B。

    `Sep 24 10:36 semester`：文件的**最后修改时间**，文件名称（.开头的表示隐藏文件，需要`ls -a`命令可以显示）。

7. 查看 chmod 的手册(例如，使用 man chmod 命令)
    ```shell
    $ man chmod
    ```
8. 使用 chmod 命令改变权限，使 ./semester 能够成功执行，不要使用 sh semester 来执行该程序。您的 shell 是如何知晓这个文件需要使用 sh 来解析呢？
    ```shell
    $ chmod 755 semester
    $ ls -l
    total 4
    -rwxr-xr-x 1 pyq-ubuntu pyq-ubuntu 63 Sep 24 10:36 semester
    ```
    > `#!/bin/sh`指明了此文件通过`/bin/sh`执行
9. 使用 | 和 > ，将 semester 文件输出的最后更改日期信息，写入主目录下的 last-modified.txt 的文件中。
    ```shell
    $ ./semester | grep last-modified > ~/last-modified.txt
    $ cat ~/last-modified.txt
    last-modified: Sat, 17 Sep 2022 10:59:54 GMT
    ```
10. 写一段命令来从 /sys 中获取笔记本的电量信息，或者台式机 CPU 的温度。
    ```shell
    $ cat /sys/class/power_supply/BAT1/capacity
    95
    ```