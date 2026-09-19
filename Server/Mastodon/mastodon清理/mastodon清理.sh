# 清理Mastodon

`docker exec -it mastodon-web-1 /bin/bash`

### --dry-run 是模拟，正式操作时不带。

## 清理文件

### 清理远程头像 + Header

RAILS_ENV=production bin/tootctl media remove --prune-profiles --days 7 --dry-run

### 清理超过 7 天的远程帖子附件

RAILS_ENV=production bin/tootctl media remove --days 7 --dry-run

### 清理 Preview Card 图片

RAILS_ENV=production bin/tootctl preview_cards remove --days 30 --dry-run

### 清理孤儿文件，非常值得在大清理后跑一次。

RAILS_ENV=production bin/tootctl media remove-orphans --dry-run

### 清理远程 Emoji，--remote-only 会只删除远程实例的 Custom Emoji

RAILS_ENV=production bin/tootctl emoji purge --remote-only

## 清 PostgreSQL

### 清理“从未与本站用户交互”的远程账号

RAILS_ENV=production bin/tootctl accounts prune --dry-run

### 清理已经不存在的远程账号

RAILS_ENV=production bin/tootctl accounts cull --dry-run

### 清理未被引用的远程嘟文

RAILS_ENV=production bin/tootctl statuses remove --days 90

## 低优先级缓存清理

### 清 Mastodon 应用缓存

RAILS_ENV=production bin/tootctl cache clear

## 危险清理命令！

### 清除关注关系中的头像/Header

RAILS_ENV=production bin/tootctl media remove --prune-profiles --include-follows --days 7

### 激进清 Header

RAILS_ENV=production bin/tootctl media remove --remove-headers --days 7

RAILS_ENV=production bin/tootctl media remove --remove-headers --include-follows --days 7

### 激进清远程 Status（包括你正在关注的远程用户的帖子）

RAILS_ENV=production bin/tootctl statuses remove --days 30 --clean_followed

### 删除来自该 DOMAIN 的所有远程账号以及相关记录

RAILS_ENV=production bin/tootctl domains purge example.com

### 清全部 Emoji（包括自己本站上传的 Emoji）

RAILS_ENV=production bin/tootctl emoji purge

## 直接删除操作

### 删除本站用户

RAILS_ENV=production bin/tootctl accounts delete USERNAME

### 重置关注关系

#### 取消关注后重新关注

RAILS_ENV=production bin/tootctl accounts reset-relationships USERNAME --follows

#### 移除该用户的 followers

RAILS_ENV=production bin/tootctl accounts reset-relationships USERNAME --followers

### 删除一切 “我要关闭整个 Mastodon 实例”

RAILS_ENV=production bin/tootctl self-destruct

### 数据库修复（官方明确要求 Mastodon 停机执行，而且可能具有破坏性）

RAILS_ENV=production bin/tootctl maintenance fix-duplicates

