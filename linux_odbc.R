用R在Linux下连接MSSQL，需要安装
apt-get install libiodbc2-dev
apt-get install libiodbc2
apt-get install unixodbc-dev
apt-get install libmyodbc
apt-get install tdsodbc
安装freetds
解压后，执行命令
./configure --prefix=/usr/local/freetds
make
sudo make install

freetds.conf 路径是：/usr/local/freetds/etc/freetds.conf

需要配置freeTDS.conf、odbcinst.ini、odbc.ini这3个文件
freeTDS.conf
# A typical Microsoft server
[egServer70]
host = 115.29.201.33
port = 12433
tds version = 7.0

路径是：/etc
odbcinst.ini
[FreeTDS]
Description   = FreeTDS unixODBC Driver
Driver        = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so
Setup         = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so

odbc.ini
[bld]
Description = Shiny testing
Driver = FreeTDS
TDS-Version = 7.2
Trace = No
Server = 115.29.201.33
Database = BLD_Ofusion_ODS
port = 12433

# 如果表里有varchar(max)类型的字段，需要转化一下类型。
job.text <- sqlQuery(ccweb5.prod,"
  SELECT DISTINCT TOP 100
    ja.JobTitle,
    [JobText] = CAST(ja.JobText AS varchar(8000)), -- note the data-type re-cast
    [JobTextLength] = LEN(ja.JobText)
  FROM JobStore.dbo.JobAd as ja (NOLOCK)
")




# 服务器版的rstudio
# sudo ufw allow 8787


