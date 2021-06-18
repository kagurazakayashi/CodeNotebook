GO 1.16 

1. 设置 github [SSH登录](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) ：免输密码证书登录。
2. 命令 `git config --global --add url."git@github.com:".insteadOf "https://github.com/"` 为 `.gitconfig` 新增（强制 https 走 SSH）：
```
[url "git@github.com:"]
	insteadOf = https://github.com/
```
3. 允许记住登录状态 `git config --global credential.helper wincred` (Windows)
  - [其他系统](https://docs.github.com/en/github/getting-started-with-github/getting-started-with-git/caching-your-github-credentials-in-git)
  - 为 `.gitconfig` 新增：
```
[credential]
	helper = wincred
```
4. 设置私有库环境变量 `export GOPRIVATE=github.com/mycompany/*`
5. 设置允许命令行输入环境变量 `env GIT_TERMINAL_PROMPT=1`
6. `go get`
  - TIMEOUT, RESET 等连接失败时[设置代理](../Proxy/git设置代理.md)