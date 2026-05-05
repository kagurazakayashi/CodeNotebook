TITLE 本地运行MCP
SET NPM_HOME=E:\npm
CD "%NPM_HOME%"
npx playwright install chromium
git clone "https://github.com/modelcontextprotocol/servers.git"
CD "%NPM_HOME%\servers\src"

ECHO fetch : 网页内容获取器。给定 URL，它会下载网页并转为 Markdown。
CD "%NPM_HOME%\servers\src\fetch"
pip install -e .
python -m mcp_server_fetch
REM Ctrl+C

ECHO filesystem : 文件系统访问。让 AI 能读写、列出和搜索你本地的文件夹。
CD "%NPM_HOME%\servers\src\filesystem"
npm install
npm run build
node "%NPM_HOME%\servers\src\filesystem\dist\index.js" "%TEMP%"
REM Ctrl+C

ECHO sequentialthinking : 序列化思维增强。强制 AI 在解决复杂问题时分步骤思考。
CD "%NPM_HOME%\servers\src\sequentialthinking"
npm install
npm run build
node "%NPM_HOME%\servers\src\sequentialthinking\dist\index.js"
REM Ctrl+C

ECHO git : Git 操作集成。让 AI 能查看提交历史、差异、暂存文件等。
CD "%NPM_HOME%\servers\src\git"
pip install -e .
python -m mcp_server_git
REM Ctrl+C

ECHO memory : 知识图谱/长效记忆。让 AI 以节点的形式记录信息，跨对话读取。
CD "%NPM_HOME%\servers\src\memory"
npm install
npm run build
node "%NPM_HOME%\servers\src\memory\dist\index.js"
REM Ctrl+C

ECHO time : 时间工具。提供当前时间和时区转换。
CD "%NPM_HOME%\servers\src\time"
pip install -e .
python -m mcp_server_time
REM Ctrl+C

ECHO everything : 全能演示/调试。包含计算器、资源模板等各种示例代码。
CD "%NPM_HOME%\servers\src\everything"
npm install
npm run build
node "%NPM_HOME%\servers\src\everything\dist\index.js"
