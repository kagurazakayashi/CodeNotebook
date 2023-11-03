# mastodon 长毛象清理长毛象
# 进入
su mastodon # docker: docker exec -it mastodon_streaming_1 /bin/sh

# 移除本地缓存的其它实例媒体附件
tootctl media remove --days 7 --concurrency 1 --verbose
# --days	多久之前的媒体附件将会被清理。默认为7天。
# --concurrency N	执行该任务的worker数。默认为5。
# --verbose	任务进行时，打印额外信息。
# --dry_run	仅打印预期结果，而不执行任何操作。

# 扫描出不属于任何媒体附件的文件并移除他们。请注意，某些存储提供商会对列出对象所必需的API收取费用。另外，此操作需要遍历每个文件，因此速度很慢。
tootctl media remove-orphans

# 移除本地预览卡片缩略图
tootctl preview_cards remove --days 180 --concurrency 1 --verbose
# --days	多久之前的媒体附件将会被清理。默认为180天。（注意：不推荐删除14天内的预览卡片，因为同一链接两周之内再次发布将不会重抓取。）
# --concurrency N	执行该任务的worker数。默认为5。
# --verbose	任务进行时，打印额外信息。
# --dry_run	仅打印预期结果，而不执行任何操作。
# --link	仅删除链接型（link-type）预览卡片。不处理视频与图片卡片。

# 从数据库中删除未被引用的嘟文
tootctl statuses remove --days 90
# --days	多久之前的嘟文将会被清理。默认为90天。

# 移除不在存在的远程帐户
tootctl accounts cull

# 清除缓存存储
tootctl cache clear

# 更多命令
# https://docs.joinmastodon.org/zh-cn/admin/tootctl/#cache

# docker 上清理
docker exec -it mastodon_web_1 /bin/bash
# 移除本地缓存的其它实例媒体附件
tootctl media remove --days 7 --concurrency 1
# 移除本地预览卡片缩略图
tootctl preview_cards remove --days 180 --concurrency 1 --verbose
# 从数据库中删除未被引用的嘟文
tootctl statuses remove --days 90
# 彻底清理媒体文件
tootctl preview_cards remove && tootctl media remove && tootctl media remove-orphans

# 定时清理脚本
docker exec mastodon_web_1 /bin/bash -c "tootctl preview_cards remove --days 180 --concurrency 1 --verbose" >/var/log/yashi/mastodonclean.log
docker exec mastodon_web_1 /bin/bash -c "tootctl media remove --days 7 --concurrency 1 --verbose" >>/var/log/yashi/mastodonclean.log
docker exec mastodon_web_1 /bin/bash -c "tootctl media remove-orphans --days 7 --concurrency 1 --verbose" >>/var/log/yashi/mastodonclean.log
docker exec mastodon_web_1 /bin/bash -c "tootctl statuses remove --days 90 --verbose" >>/var/log/yashi/mastodonclean.log
