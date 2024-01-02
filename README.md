需要本机安装docker和git

复制代码到本地

```
git clone https://github.com/df123/docker_build_aria2.git
```

进入目录文件运行

```
docker build -t aria2build -f aria2build.dockerfile .
```

完成后使用将文件复制出来

```
docker cp [id]:/aria2/src/aria2c .
```

添加代理，将文件中的ip:port替换成你的代理地址
