# oracle学习笔记

新搭建的oracle数据库 启用orclpdb（使用sys登入的时，默认使用的服务是orcl【需要理解下orcl和orclpdb的区别】）
```
alter session set container = orclpdb
alter database open
```

然后创建新用户（简略版）
```
create user 用户名 identified by 密码
```
然后创建新用户（详细版）
```
create user Cloud--用户名
identified by "Wfy123456"--密码
default tablespace USERS--表空间名
temporary tablespace temp --临时表空间名
profile DEFAULT --数据文件（默认数据文件）
account unlock; -- 账户是否解锁（lock:锁定、unlock解锁）
```
用户创建完成后，就会生成对应的”库“
然后需要给用户赋予相应的权限（connect, resource, dba）

oracle角色是若干系统权限的集合，给用户进行授数据库角色，就是等于赋予该用户若干数据库系统权限。常用的数据库角色如下：
+ CONNECT角色：connect角色是Oracle用户的基本角色，connect权限代表着用户可以和Oracle服务器进行连接，建立session（会话）。
+ RESOURCE角色：resouce角色是开发过程中常用的角色。 RESOURCE给用户提供了可以创建自己的对象，包括：表、视图、序列、过程、触发器、索引、包、类型等。
+ DBA角色：DBA角色是管理数据库管理员该有的角色。它拥护系统了所有权限，和给其他用户授权的权限。SYSTEM用户就具有DBA权限。

同时要给用户赋予表空间的权限（如果使用简略版创建用户，默认表空间为USERS)
赋予权限 给予connect和resource权限即可
```
grant connect, resource to 用户名
```
撤销权限 
```
revoke connect, resource from 用户名;
```
表空间赋权
```
alter user 用户名 quota unlimited on 表空间名;
```
oracle链接的两种写法 千万注意！
```
//监听sid服务，表示sid为orcl
database.url=jdbc:oracle:thin:@ip:port:orcl
//监听服务名，表示服务名为orcl
database.url=jdbc:oracle:thin:@ip:port/orcl
```

创建表空间
```
CREATE TABLESPACE TEST LOGGING DATAFILE '/data/app/oracle/oradata/orcl/TEST.dbf' SIZE 1000M AUTOEXTEND ON NEXT 1000M MAXSIZE 30720M EXTENT MANAGEMENT LOCAL;
```
创建临时表空间
```
CREATE TEMPORARY TABLESPACE TEMP01 TEMPFILE '/data/app/oracle/oradata/orcl/tmple01.dbf' SIZE 1024M AUTOEXTEND ON NEXT 100M MAXSIZE 20480M EXTENT MANAGEMENT LOCAL;
```
三大范式
```
第一范式：每个列都不可以再拆分。

第二范式：在第一范式的基础上，非主键列完全依赖于主键，而不能是依赖于主键的一部分。

第三范式：在第二范式的基础上，非主键列只依赖于主键，不依赖于其他非主键。
```

在CDB容器中用户名必须加c##前缀才能创建成功 不然会报"ORA-65096: 公用用户名或角色名无效" 的异常

https://blog.csdn.net/gao88690934/article/details/120438953

https://blog.csdn.net/JiaLingDeKrabs/article/details/103850841?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522166539786616800192286472%2522%252C%2522scm%2522%253A%252220140713.130102334..%2522%257D&request_id=166539786616800192286472&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~top_positive~default-1-103850841-null-null.142^v52^control,201^v3^add_ask&utm_term=%E8%A1%A8%E7%A9%BA%E9%97%B4&spm=1018.2226.3001.4187

https://blog.csdn.net/dreamsigel/article/details/124747560