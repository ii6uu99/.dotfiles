https://github.com/klutchell/compose-bin.git

docker通用脚本


# compose-bin #

## Description ##

管理docker和docker-compose项目的通用shell脚本。一般包括作为其他项目的子模块。

安装
https://github.com/blog/2104-working-with-submodules
```bash
$ cd /main/project
$ git submodule add -b master git@github.com:klutchell/compose-bin.git bin
$ git commit -m "compose-bin submodule"
$ git submodule update --init --recursive
```

用法
子模块是它自己的repo / work-area，它有自己的.git目录。所以，首先提交/推送你的子模块的变化：
$ cd path/to/submodule
$ git add <stuff>
$ git commit -m "comment"
$ git push
```

然后告诉你的主要项目跟踪更新的版本：
$ cd /main/project
$ git add path/to/submodule
$ git commit -m "updated my submodule"
$ git push
```

## Contributing ##

n/a

## Author ##

Kyle Harding <kylemharding@gmail.com>

## Credit ##

n/a
