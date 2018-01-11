https://github.com/mateothegreat/docker-centos-desktop-visualstudiocode


！[docker]（http://i.imgur.com/rAuZnDH.png）
通过VNC和RDP在CentOS的上运行的独立容器部署。

此图像附带Visual Studio代码（内部人员版本）和预先安装的依赖关系。启动容器，连接一个VNC客户端，然后启动并运行。有几个开源的VNC客户端，如TightVNC，TigerVNC和Realvnc。

通过VNC连接到容器

## Building the Docker Image

```bash
$ cd docker-centos-desktop-visualstudiocode
$ docker build -t appsoa/docker-centos-desktop-visualstudiocode .          
```

启动容器
您可以通过运行删除先前启动的vscode容器docker rm -f vscode。
```bash
docker run -id  -e CONF_VNC_PASS=changeme \
                -e CONF_VNC_PORT=5901 \
                -p 5901:5901 \
                --name vscode \
                 appsoa/docker-centos-desktop-visualstudiocode


```

## Gaining a shell
作为默认用户“用户”
 `docker exec -it vscode /bin/bash`. 
如果您需要root shell，您可以传递参数-u
 `docker exec -it -u 0 vscode /bin/bash`

创建一个持久卷
每个容器用户都有一个用于维护设置和状态的永久性目录。
创建一个模板/标准基本图像：

    ```bash
    $ gcloud compute    disks create \
                        disk-name \
                        --description "Persistent Volume for user home directory." \
                        --size 10 \
                        --image user-template
    ```
0. 创建磁盘映像：

    ```
    $ gcloud compute images delete user-image -q
    $ gcloud compute images create user-image --source-disk user-template
    Created [https://www.googleapis.com/compute/v1/projects/virtualmachines-154415/global/images/algolab-user-image].
    NAME                PROJECT                 FAMILY  DEPRECATED  STATUS
    user-image  virtualmachines-154415                      READY
    ```

0. 将新磁盘附加到正在运行的VM

如果您需要对文件系统进行更改，则可以将新磁盘安装到任何正在运行的虚拟机上。您将首先使用gcloud cli附加磁盘，然后在主机操作系统上执行mount命令。



    ```bash
    $ gcloud compute instances attach-disk large --disk algolab-user-template
    ```

0. 挂载磁盘并更新文件/目录：

    ```bash
    $ mount -o discard,defaults /dev/disk/by-id/google-persistent-disk-2 /home/user123
    $ ls -la /home/user123
    total 24
    drwxr-xr-x. 3 root root  4096 Jan 19 19:30 .
    drwxr-xr-x. 9 root root  4096 Jan 19 19:32 ..
    drwx------. 2 root root 16384 Jan 19 19:30 lost+found
    ```
0. 分离磁盘：

    ```bash
    $ gcloud compute instances detach-disk vm-instance-id --disk disk-name
    ```
0.创建一个新的，空的和格式化的持久磁盘

通过gcloud cli创建持久磁盘后，您将使用格式化磁盘mkfs.ext4。一旦格式化，您可以（可选）安装磁盘并对文件系统进行更改。
    ```bash
    $ gcloud compute instances attach-disk vm-instance-id --disk user-template
    $ gcloud compute instances detach-disk vm-instance-id --disk user-template
    
    $ sudo mkfs.ext4 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/disk/by-id/google-persistent-disk-2
        
        mke2fs 1.42.9 (28-Dec-2013)
        Discarding device blocks: done
        Filesystem label=
        OS type: Linux
        Block size=4096 (log=2)
       
        Stride=0 blocks, Stripe width=0 blocks
        32768000 inodes, 131072000 blocks
        6553600 blocks (5.00%) reserved for the super user
        First data block=0
        Maximum filesystem blocks=2279604224
        4000 block groups
        32768 blocks per group, 32768 fragments per group
        8192 inodes per group
        Superblock backups stored on blocks:
                32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
                4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
                102400000
    
        Allocating group tables: done
        Writing inode tables: done
        Creating journal (32768 blocks): done
        Writing superblocks and filesystem accounting information: done
    ```
