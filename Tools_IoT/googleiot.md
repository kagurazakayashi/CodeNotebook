# 创建您的第一个 Cloud Pub/Sub 主题
- Cloud Pub/Sub 主题是作为设备消息发送目标的指定资源。使用以下命令创建您的第一个主题：
- `gcloud pubsub topics create test-topic`
  - 返回 `Created topic [projects/test-project/topics/test-topic].`
- 可以在 Pub/Sub 功能中的「主题」看到

# 创建对设备主题的订阅
- 运行以下命令来创建订阅，这样您就能查看设备发布的消息了：
- `gcloud pubsub subscriptions create projects/[项目名称]/subscriptions/[新建的订阅名称] --topic=[刚才创建的主题名称]`
  - `gcloud pubsub subscriptions create projects/test-project/subscriptions/test-subscription --topic=test-topic`
- 可以在 Pub/Sub 功能中的「订阅」看到

# 从 GitHub 克隆 Cloud IoT Core Node.js 示例文件
- 您将使用 MQTT 示例向 Cloud IoT Core 发送消息。
- `git clone https://github.com/googleapis/nodejs-iot.git`

# 向 Cloud IoT Core 服务帐号授予权限
在本部分中，您要使用帮助程序脚本，将 cloud-iot@system.gserviceaccount.com 服务帐号添加到 Cloud Pub/Sub 主题，并授予 Publisher 角色。
- 转到 iot/ 目录： `cd nodejs-iot/samples/`
- 安装依赖项： `npm --prefix ./scripts install`
- 运行帮助程序脚本： `node scripts/iam.js test-topic`

## 被要求创建服务账户:
- <https://cloud.google.com/docs/authentication/getting-started#cloud-console>
- 创建环境变量 `GOOGLE_APPLICATION_CREDENTIALS` 指向到 json 密钥路径

# 创建设备注册表
- `gcloud iot registries create [新建注册表名称] --project=[项目名称] --region=[可用区] --event-notification-config=topic=projects/[项目名称]/topics/[主题]`
  - `gcloud iot registries create test-registry --project=testproject --region=us-central1 --event-notification-config=topic=projects/testproject/topics/test-topic`
    - `Created registry [test-registry].`
- 可以在「IoT Core」的「注册表详情」-「注册表ID：」看到。

# 创建您的凭据

## 生成设备密钥对
- 为了对 Cloud IoT Core 进行身份验证，设备需要一个私钥和一个公钥。通过运行以下命令来生成您的签名密钥：
- `./scripts/generate_keys.sh`
```
Generating a RSA private key
.............................+++++
...........................................................................................+++++
writing new private key to 'rsa_private.pem'
-----
read EC key
writing EC key
```
- 新增文件: `ec_private.pem`, `ec_public.pem`, `rsa_cert.pem`, `rsa_private.pem` ，使用后两个。
- 此脚本会创建 PEM 格式的 RS256 和 ES256 密钥，但您在本教程中只需要 RS256 密钥。私钥必须安全地存储在设备中，并用于对身份验证 [JWT（JSON 网络令牌）](https://cloud.google.com/iot/docs/how-tos/credentials/jwts?hl=zh-CN) 进行签名。公钥存储在设备注册表中。

## 下载根凭据
- 下载 Google 的 CA 根证书。稍后运行 Node.js 命令时将需要使用该文件。
- `wget https://pki.goog/roots.pem`

# 创建设备并将其添加到注册表中
- 运行以下命令来创建一个设备并将其添加到注册表中：
- `gcloud iot devices create [新建设备名称] --project=[项目名称] --region=[可用区] --registry=[注册表名称] --public-key path=[公钥文件],type=rs256`
  - `gcloud iot devices create test-device --project=testproject --region=us-central1 --registry=test-registry --public-key path=rsa_cert.pem,type=rs256`
    - 返回 `Created device [test-device].`
- 可以在「IoT Core」的「设备」-「注册表ID：」看到。

# 连接设备并发布消息
在本部分中，您要从虚拟设备向 Cloud Pub/Sub 发送消息。

1. 转到 MQTT 示例目录 `cd mqtt_example`
2. 安装 Node.js 依赖项 `npm install`
3. 使用 MQTT 网桥将虚拟设备连接到 Cloud IoT Core
`node cloudiot_mqtt_example_nodejs.js mqttDeviceDemo --cloudRegion=[可用区] --projectId=[项目名称] --registryId=[注册表名称] --deviceId=[设备名称] --privateKeyFile=[私钥文件] --serverCertFile=[Google的CA根证书文件] --numMessages=[发送消息数量] --algorithm=RS256 --mqttBridgePort=443`

node cloudiot_mqtt_example_nodejs.js mqttDeviceDemo --cloudRegion=us-central1 --projectId=testproject --registryId=test-registry --deviceId=test-node-device --privateKeyFile=../rsa_private.pem --serverCertFile=../roots.pem --numMessages=25 --algorithm=RS256 --mqttBridgePort=443
