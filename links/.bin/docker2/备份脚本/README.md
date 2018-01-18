https://github.com/mgreenly/backupscript.git


备份脚本
一些简单的备份脚本我使用或已经使用。

我的基本策略是使用rsync将我的主目录的当前内容复制到使用ZFS或BTRFS的驱动器上，以便我可以在rsync之后进行快照。然后将快照保留一段时间，修剪较旧的快照。
