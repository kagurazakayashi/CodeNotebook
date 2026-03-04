TITLE 对当前文件夹及其子文件夹中的特定扩展名的所有文件进行操作 遍历文件处理

@ECHO OFF
REM 获取批处理文件的完整路径
SET "batchFilePath=%~f0"

REM 遍历当前文件夹及其子文件夹中的所有文件
FOR /R %%F IN (*.tar) DO (
    REM 跳过批处理文件本身
    IF /I NOT "%%~fF"=="%batchFilePath%" (
        REM 获取文件路径和扩展名
        SET "filePath=%%~dpF"
        SET "fileName=%%~nxF"
        SET "fileExt=%%~xF"

        REM 使用独立的 CMD 执行命令，确保初始目录为文件所在的文件夹
        PUSHD "%%~dpF"
        FOR %%C IN (.) DO ECHO 当前目录: %%~fC
        ECHO 当前文件: "%%~nxF" 无扩展名: "%%~nF"
        POPD
    )
)

REM 清理设置的变量
SET "batchFilePath="
SET "filePath="
SET "fileName="
SET "fileExt="
