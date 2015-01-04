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
