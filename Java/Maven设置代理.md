- 用 `mvn help:effective-settings` 可以查看当前生效的settings.xml (会自动装插件)

- `mvn -X` 命令可以查看settings.xml文件的读取顺序（可以直接看到）

- 创建 settings.xml： `cp /usr/share/maven/conf/settings.xml ~/.m2/setting.xml`

# 设置代理
`vim ~/.m2/setting`
```
<proxies>
    <proxy>
            <id>ss</id>
            <active>true</active>
            <protocol>http</protocol>
            <host>127.0.0.1</host>
            <port>1081</port>
            <nonProxyHosts>127.0.0.1</nonProxyHosts>
    </proxy>
</proxies>
```

# 使用国内的阿里源
`vim ~/.m2/setting`
```
<mirror>
    <id>alimaven</id>
    <name>aliyun maven</name>
    <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
    <!--mirrorOf>central</mirrorOf-->   
    <mirrorOf>*</mirrorOf>   
</mirror>
```