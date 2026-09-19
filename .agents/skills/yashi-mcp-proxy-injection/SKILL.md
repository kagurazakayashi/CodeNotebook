---
name: yashi-mcp-proxy-injection
description: 为任意读取网址或通过非中国搜索引擎（Google、Bing 国际版等）搜索的本地 MCP 服务器注入代理，解决其联网失败(fetch failed、chromium ERR_TIMED_OUT / ERR_CONNECTION_TIMED_OUT、无法访问被墙的 API 或搜索引擎)。通用方法论：适用于任意此类 MCP 服务器、任意 MCP host（opencode / Claude Code / Claude Desktop / Cline 等）与任意本地代理服务器（HTTP CONNECT 或 SOCKS5），代理地址通过环境变量可配置，不绑定特定插件。安装此类 MCP 服务器时，先询问用户是否需要代理补丁、以及代理到哪个地址，确认后再动手。Use when installing, repairing, or diagnosing a network-using MCP that cannot reach the internet, when the MCP host's `env` proxy setting has no effect, or when re-injecting proxy patches after `npm update -g` overwrote them.
---

# MCP Proxy Injection

Inject a proxy into MCP servers whose network requests fail because they don't
honor a proxy on their own.

## When to use

- A network-using MCP fails: `fetch failed`, chromium `ERR_TIMED_OUT` /
  `ERR_CONNECTION_TIMED_OUT`, or timeouts reaching Google / a geo-blocked API.
- Installing a new browser- or fetch-based MCP that needs a proxy.
- Re-injecting patches after `npm update -g` overwrote them.

## Ask first: 安装时先询问，不要擅自打补丁

安装/部署任何**读取网址或通过非中国搜索引擎搜索**的本地 MCP 服务器（fetch、browser、search 类）时，**先问用户，再动手**：

1. **是否需要代理补丁？**（此类 MCP 通常要访问境外站点，默认建议需要，但仍要确认）
   - 不需要（如仅访问国内站点、或 MCP host 已能传递 `env` 代理）：跳过补丁，正常配置即可。
2. **代理到哪里？**（若需要）
   - 给出本机默认 `http://127.0.0.1:23333`，同时接受用户指定的任意 HTTP CONNECT / SOCKS5 地址（如 `socks5://127.0.0.1:23332`、`http://127.0.0.1:7890`）。
   - 确认后把地址写入环境变量 `MCP_PROXY_SERVER`（或作为补丁 fallback 的默认值），不要硬编码到多个位置。
3. 完成后在答复中说明：**补丁位置、代理地址、生效方式**（环境变量 vs 补丁 fallback），并提示重启 MCP host 后验证。

> 本机历史约定：已部署的 brave-search / g-search / fetcher 使用变量名 `MYMCP_PROXY_SERVER`，与 `MCP_PROXY_SERVER` 等效；新安装统一用 `MCP_PROXY_SERVER`。

## Proxy resolution (configurable, not hardcoded)

All templates below resolve the proxy from environment variables, in priority order:

```js
process.env.MCP_PROXY_SERVER || process.env.HTTPS_PROXY || process.env.HTTP_PROXY || "http://127.0.0.1:23333"
```

- Set `MCP_PROXY_SERVER` (dedicated, recommended) or the standard `HTTPS_PROXY`/`HTTP_PROXY` to point at **your** local proxy.
- 本机历史部署（brave-search / g-search / fetcher）使用变量名 `MYMCP_PROXY_SERVER`，与本技能的 `MCP_PROXY_SERVER` 等效；两者都是受支持的专用变量，不必改已有补丁。
- HTTP CONNECT proxies (e.g. Clash on `127.0.0.1:23333`) work for both chromium and fetch; SOCKS5 (`socks5://127.0.0.1:23332`) works for chromium but is unreliable for undici `fetch` in our experience — prefer HTTP when in doubt.
- The fallback `http://127.0.0.1:23333` is a local convention; change it in one place (the env var) rather than editing every patch.
- If domestic sites fail *through* the proxy, the proxy client needs a direct rule (e.g. Clash `GEOIP,CN,DIRECT`) — this is a proxy-client config issue, not the MCP's.

## Diagnose first

1. Confirm the proxy itself works (adjust `-o NUL` to `-o /dev/null` on Linux/macOS):
   `curl -x $MCP_PROXY_SERVER -s -o NUL -w "%{http_code}" https://<target>/`
2. For a chromium-based MCP, test the bundled browser directly, with and
   without an explicit proxy:
   `"<...>\chrome-headless-shell.exe" --headless --no-sandbox --proxy-server="$MCP_PROXY_SERVER" --dump-dom "https://www.google.com/" > out.html`
   Success *with* `--proxy-server` but failure *without* it proves the MCP is
   not handing the proxy to chromium — apply method A below.

## Injection methods

### A. Playwright / chromium MCP (browser-based)

Patch the top of the file that calls `chromium.launch`, wrapping it to force
`proxy`. One wrapper covers every launch site in the file:

```js
import { chromium } from "playwright";
const __PROXY = process.env.MCP_PROXY_SERVER || process.env.HTTPS_PROXY || process.env.HTTP_PROXY || "http://127.0.0.1:23333";
const __origLaunch = chromium.launch.bind(chromium);
chromium.launch = (o = {}) => __origLaunch({ ...o, proxy: { server: __PROXY } });
```

### B. Node built-in `fetch` MCP (API-based)

The built-in `fetch` (undici) routes through a global dispatcher. Requires the
`undici` package (`npm i -g undici` if missing; it resolves from the global
`node_modules` root). Patch the entry file:

```js
import { ProxyAgent, setGlobalDispatcher } from "undici";
setGlobalDispatcher(new ProxyAgent(process.env.MCP_PROXY_SERVER || process.env.HTTPS_PROXY || process.env.HTTP_PROXY || "http://127.0.0.1:23333"));
```

Note: Node's `NODE_USE_ENV_PROXY=1` + `HTTP(S)_PROXY` also works for a directly
spawned node process, but is unreliable here because many MCP hosts (e.g.
opencode) don't pass the MCP `env` through — so patch instead of relying on it.

If the server uses `playwright`'s `browserType.launch`, `puppeteer.launch`, or
chromium's `--proxy-server` flag instead of the built-in `fetch`, apply the same
idea: wrap the launch call (method A) or prepend `--proxy-server` to the launch
args (method C below).

### C. Chromium flag MCP (launch-args based)

When the MCP launches chromium with an explicit arg list (e.g. puppeteer or a
custom launcher), inject the flag instead of wrapping:

```js
const __PROXY = process.env.MCP_PROXY_SERVER || process.env.HTTPS_PROXY || process.env.HTTP_PROXY || "http://127.0.0.1:23333";
// 在启动参数数组中加入：
// '--proxy-server=' + __PROXY
```

## After patching

1. Point your MCP host config (`opencode.json` `mcp.<name>.command`, Claude Desktop `claude_desktop_config.json`, etc.) at `node <entry>` — bypass `npx`, which spawns fresh unpatched copies. For hosts that allow env overrides, set `MCP_PROXY_SERVER` there instead of editing the patch.
2. Syntax-check: `node --check <patched-file>`.
3. Restart the MCP host, then call the MCP tool to confirm.

本机当前部署的 MCP（brave-search / g-search / fetcher）的具体补丁位置、入口与版本等台账信息见回收站中的 `yashi-mcp-setup`（2026-09-15 删除，可从回收站恢复）；本技能保持通用方法论，不绑定具体部署。
