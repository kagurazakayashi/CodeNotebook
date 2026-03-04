# 遍历文件夹及所有文件
for /R %%s in (*.png) do (
    echo %%s
    echo %%~ns
)

# 仅遍历文件夹名
for /D %%s in (*) do (
    echo %%s
)
