@REM 查询系统状态 压缩系统压缩
compact /compactos:query

@REM Compact压缩

@REM 开启CompactOS
compact /compactos:always

@REM 关闭CompactOS
compact /compactos:never

@REM 最高压缩当前文件夹中的所有文件，包括隐藏和系统文件
COMPACT /C /S /A /I /Q /EXE:LZX

@REM COMPACT [/C | /U] [/S[:dir]] [/A] [/I] [/F] [/Q] [/EXE[:algorithm]]
@REM        [/CompactOs[:option] [/WinDir:dir]] [filename [...]]

@REM  /C       压缩指定的文件。将对目录进行标记，
@REM            以便压缩随后添加的文件，除非 /EXE
@REM            已指定。
@REM  /U       解压缩指定的文件。将对目录进行标记，
@REM            这样就不会压缩随后添加的文件。如果指定了
@REM            /EXE，则只有压缩为可执行文件的文件才会
@REM            进行解压缩；如果省略此项，则只有 NTFS 压缩
@REM            文件才会进行解压缩。
@REM  /S       对给定目录和所有子目录中的文件
@REM            执行指定的操作。默认 "dir" 是
@REM            当前目录。
@REM  /A       显示包含隐藏属性或系统属性的文件。默认情况下，
@REM            这些文件将被省略。
@REM  /I       即使在出现错误后也继续执行
@REM            指定的操作。默认情况下，COMPACT 将在遇到错误
@REM            时停止。
@REM  /F       对所有指定文件强制执行压缩操作，即使
@REM            是已压缩的文件也是如此。默认情况下，将跳过
@REM            已压缩的文件。
@REM  /Q       仅报告最重要的信息。
@REM  /EXE     使用针对经常读取但未修改的可执行文件
@REM            优化的压缩。支持的算法是:
@REM            XPRESS4K  (最快速) (默认)
@REM            XPRESS8K
@REM            XPRESS16K
@REM            LZX      (压缩程度最高)
@REM   /CompactOs 设置或查询系统的压缩状态。支持的选项包括:
@REM             query  - 查询系统的压缩状态。
@REM             always - 压缩所有 OS 二进制文件并将系统状态设置为"压缩"，
@REM                      这种状态一直保持到管理员更改它。
@REM             never  - 解压缩所有 OS 二进制文件并将系统状态设置为"未压缩"，
@REM                      这种状态一直保持到管理员更改它。
@REM  /WinDir    在查询脱机 OS 时与 /CompactOs:query 一起使用。指定
@REM             Windows 所安装到的目录。
@REM   filename  指定模式、文件或目录。

@REM   不跟参数一起使用时，COMPACT 显示当前目录及其所含文件的
@REM   压缩状态。你可以使用多个
@REM   文件名和通配符。在多个参数之间
@REM   必须加空格。
