# Usage: xmrig [OPTIONS]

# 网络:
- -o, --url=URL                 矿池URL加端口
- -a, --algo=ALGO               挖掘算法 https://xmrig.com/docs/algorithms
-     `--coin=COIN`               指定硬币而不是算法
- -u, --user=USERNAME           钱包地址或挖矿服务器的用户名
- -p, --pass=PASSWORD           挖矿服务器密码
- -O, --userpass=U:P            用户名：挖矿服务器的密码对
- -k, --keepalive               发送keepalived数据包以防止超时（需要池支持）
-     --nicehash                启用nicehash.com支持
-     --rig-id=ID               池侧统计信息的钻机标识符（需要池支持）
-     --tls                     启用SSL / TLS支持（需要池支持）
-     --tls-fingerprint=HEX     池TLS证书指纹以进行严格的证书固定
-     --daemon                  使用守护程序RPC而不是池进行单独挖掘
-     --daemon-poll-interval=N  守护程序轮询间隔（以毫秒为单位）（默认值：1000）
-     --self-select=URL         self-select block templates from URL
- -r, --retries=N               切换到备份服务器前重试的次数（默认值：5）
- -R, --retry-pause=N           重试之间暂停的时间（默认值：5）
-     --user-agent              设置矿池的自定义用户代理字符串
-     --donate-level=N          捐赠水平，默认为5 %%（100分钟内5分钟）
-     --donate-over-proxy=N     控制通过xmrig-proxy功能捐赠

# CPU 后台:
      --no-cpu                  禁用CPU挖矿
  -t, --threads=N               CPU线程数
  -v, --av=N                    算法变化，0自动选择
      --cpu-affinity            设置与CPU内核的进程关联性，为内核0和1设置掩码0x3
      --cpu-priority            设置进程优先级（0空闲，2正常到5最高）
      --cpu-max-threads-hint=N  自动配置的最大CPU线程数（百分比）提示
      --cpu-memory-pool=N       永久性内存池的2 MB页面数，-1（自动），0（禁用）
      --cpu-no-yield            prefer maximum hashrate rather than system respo
nse/stability
      --no-huge-pages           禁用大页面支持
      --asm=ASM                 ASM优化，可能的值：auto，none，intel，ryzen，bulldozer
      --argon2-impl=IMPL        argon2 implementation: x86_64, SSE2, SSSE3, XOP,
 AVX2, AVX-512F
      --randomx-init=N          线程计数以初始化RandomX数据集
      --randomx-no-numa         禁用对RandomX的NUMA支持
      --randomx-mode=MODE       RandomX模式：自动，快速，轻便
      --randomx-1gb-pages       use 1GB hugepages for RandomX dataset (Linux onl
y)                                                                                              --randomx-wrmsr=N         write custom value(s) to MSR registers or disabl
e MSR mod (-1)
      --randomx-no-rdmsr        disable reverting initial MSR values on exit
      --randomx-cache-qos       enable Cache QoS                                      --astrobwt-max-size=N     skip hashes with large stage 2 size, default: 55
0, min: 400, max: 1200
      --astrobwt-avx2           enable AVX2 optimizations for AstroBWT algorithm

# OpenCL 后台:
      --opencl                  启用OpenCL挖掘后端(A卡挖矿)
      --opencl-devices=N        以逗号分隔的要使用的OpenCL设备列表
      --opencl-platform=N       OpenCL平台索引或名称
      --opencl-loader=PATH      OpenCL-ICD-Loader的路径（OpenCL.dll或libOpenCL.so）
      --opencl-no-cache         禁用OpenCL缓存
      --print-platforms         打印可用的OpenCL平台并退出

# CUDA 后台:
      --cuda                    启用CUDA挖掘后端(N卡挖矿)
      --cuda-loader=PATH        CUDA插件的路径（xmrig-cuda.dll或libxmrig-cuda.so）
      --cuda-devices=N          以逗号分隔的要使用的CUDA设备列表
      --cuda-bfactor-hint=N     自动配置的bfactor提示（0-12）
      --cuda-bsleep-hint=N      自动配置的睡眠提示
      --no-nvml                 禁用NVML（NVIDIA管理库）支持

# API:
      --api-worker-id=ID        API的自定义工作程序ID
      --api-id=ID               API的自定义实例ID
      --http-host=HOST          绑定HTTP API的主机（默认值：127.0.0.1）
      --http-port=N             绑定HTTP API的端口
      --http-access-token=T     HTTP API的访问令牌
      --http-no-restricted      启用对HTTP API的完全远程访问（仅在设置了访问令牌的情况下）

# TLS:
      --tls-gen=HOSTNAME        generate TLS certificate for specific hostname
      --tls-cert=FILE           load TLS certificate chain from a file in the PEM format
      --tls-cert-key=FILE       load TLS certificate private key from a file in
the PEM format
      --tls-dhparam=FILE        load DH parameters for DHE ciphers from a file in the PEM format
      --tls-protocols=N         enable specified TLS protocols, example: "TLSv1
TLSv1.1 TLSv1.2 TLSv1.3"
      --tls-ciphers=S           set list of available ciphers (TLSv1.2 and below)
      --tls-ciphersuites=S      set list of available TLSv1.3 ciphersuites

# 日志:
  -S, --syslog                  使用系统日志输出消息
  -l, --log-file=FILE           将所有输出记录到文件
      --print-time=N            每N秒打印一次哈希率报告
      --health-print-time=N     每N秒打印一次健康报告
      --no-color                禁用彩色输出
      --verbose                 verbose output

# 其他:
  -c, --config=FILE             加载JSON格式的配置文件
  -B, --background              隐藏运行挖矿工具
  -V, --version                 输出版本信息并退出
  -h, --help                    显示此帮助并退出
      --dry-run                 测试配置并退出
      --export-topology         将hwloc拓扑导出到XML文件并退出
      --pause-on-battery        pause mine on battery power