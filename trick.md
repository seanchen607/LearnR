- Linux中的`wc`命令查看文件的行数  

- 杀死进程 
```bash
$ ps -ef | grep firefox
$ pgrep firefox
#1827
$ kill -s 9 1827

$ pgrep firefox | xargs kill -s 9
```

- 打开端口8787 `sudo ufw allow 8787`   

- 创建一个文件 `touch test.txt`  

- 在Linux下不用扩展名来决定文件类型 `file test.txt`

- 删除空文件夹 `rmdir test`，`rm -r test`将 test子目录及子目录中所有档案删除 