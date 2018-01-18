Docker清理脚本：
================================================================================

1. 删除泊坞窗图片用“”作为标签名称。
docker rmi -f $(docker images | grep -w "<none>" | awk {print $3})```

2. 删除“死”或“已退出”容器。
docker rm $(docker ps -a | grep "Dead\|Exited" | awk '{print $1}')```

3. 删除晃来晃去的泊坞窗图像。
docker rmi -f $(docker images -qf dangling=true)```

4.删除大于一个月的码头图像。
docker rmi -f $(docker images | awk '{print $3,$4,$5}' | grep '[5-9]\{1\}\ weeks\|years\|months' | awk '{print $1}')```

5. 除或清理未使用的码头卷。
docker rmi -f $(docker volume ls -qf dangling=true)```
