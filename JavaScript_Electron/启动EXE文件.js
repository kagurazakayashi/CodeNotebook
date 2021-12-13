/**
 * @param {string} exeFile 可執行檔案的名稱（例如 run.exe ）
 * @param {string} exePath 可執行檔案的路徑（相對路徑）
 * @param {bool} isFillPath 可執行檔案的路徑視為完整路徑
 * @return {number} 该进程的 PID
 */
run(exeFile, exePath = '', isFillPath = false)
{
    let cmdPath = isFillPath ? exePath : path.resolve(__dirname, exePath);
    if (cmdPath.length == 0) {
        cmdPath = __dirname;
    }
    const exe = exec.spawn;
    const workerProcess = exe(exeFile, { cwd: cmdPath });
    const fillPath = path.resolve(cmdPath, exeFile);
    console.log('START', fillPath);
    workerProcess.stdout.on('data', function (data) {
        console.log('OUT', data);
    });
    workerProcess.stderr.on('data', function (data) {
        console.log('ERR', data);
    });
    workerProcess.on('close', function (code) {
        console.log('EXIT', code);
    });
    const pid = workerProcess.pid;
    this.workerProcessArray[pid] = workerProcess;
    return pid;
}

// 参数说明：
// cwd：当前工作路径。
// env：环境变量。
// encoding：编码，默认是utf8。
// shell：用来执行命令的shell，unix上默认是/bin/sh，windows上默认是cmd.exe。
// timeout：默认是0。
// killSignal：默认是SIGTERM。
// uid：执行进程的uid。
// gid：执行进程的gid。
// maxBuffer： 标准输出、错误输出最大允许的数据量（单位为字节），如果超出的话，子进程就会被杀死。默认是200*1024（就是200k啦）