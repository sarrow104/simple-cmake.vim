# 生成简单cmake工程文件的vim插件

----------------------------------------------------------------------

## 安装：

.vimrc下，添加如下行：

```vim
Plugin 'sarrow104/simple-cmake.vim.git'
```

## 使用

```vim
:GenCMakeSimple
```

即会在当前文件所在目录位置，生成两个文件CMakeLists.txt和Makefile；此时，使用：

```vim
:make
```

```vim
:make Debug
```

或者在shell中执行类似的语句，就会进行编译——如果没有遇到错误的话；

可执行文件，将以当前文件夹名为名字；至于中间文件，都在./Release或者./Debug文件夹下面；

祝使用愉快！
