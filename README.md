# 安装lua环境

## 安装

```bash
curl -R -O http://www.lua.org/ftp/lua-5.3.4.tar.gz
tar zxf lua-5.3.4.tar.gz
cd lua-5.3.4
sudo make linux test
sudo make install
```

## 在make linux test后报错

```bash
...
gcc -std=gnu99 -O2 -Wall -Wextra -DLUA_COMPAT_5_2 -DLUA_USE_LINUX    -c -o lua.o lua.c
lua.c:82:31: fatal error: readline/readline.h: No such file or directory
 #include <readline/readline.h>
                               ^
compilation terminated.
make[2]: *** [lua.o] Error 1
make[2]: Leaving directory `/home/xx/lua-5.3.4/src'
make[1]: *** [linux] Error 2
make[1]: Leaving directory `/home/xx/lua-5.3.4/src'
make: *** [linux] Error 2
```

## 解决方法

```bash
sudo apt-get install libreadline-dev
```

[API文档](https://cloudwu.github.io/lua53doc/)
