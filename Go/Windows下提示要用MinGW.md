# runtime/cgo

```log
gcc_libinit_windows.c:6:2: 错误：#error "don't use the cygwin compiler to build native Windows programs; use MinGW instead"
    6 | #error "don't use the cygwin compiler to build native Windows programs; use MinGW instead"
      |  ^~~~~
```

- 不要用 Cygwin 的 gcc
- 推荐使用 MSYS2 的 MinGW 工具链

```bash
choco install msys2
pacman -Syu
pacman -S mingw-w64-x86_64-gcc
```

将以下路径添加到系统环境变量 PATH 中: `C:\tools\msys64\mingw64\bin`

`gcc --version` 输出中应包含 x86_64-w64-mingw32 / MSYS2 字样。

```log
gcc (Rev3, Built by MSYS2 project) 14.2.0
Copyright (C) 2024 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

**注意：不是 `C:\tools\msys64\usr\bin`**
