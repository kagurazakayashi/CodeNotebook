UPDATE yashi_posts SET post_content = replace(post_content,'http://www.heartunlock.com','http://yashi.uuu.moe');
UPDATE yashi_comments SET comment_content = replace(comment_content,'http://www.heartunlock.com','http://yashi.uuu.moe');
UPDATE yashi_comments SET comment_author_url = replace(comment_author_url,'http://www.heartunlock.com','http://yashi.uuu.moe');
UPDATE yashi_options SET option_value = replace( option_value, 'http://www.heartunlock.com','http://yashi.uuu.moe') WHERE option_name = 'home' OR option_name ='siteurl';

UPDATE yashi_posts SET post_content = replace(post_content,'http://heartunlock.com','http://yashi.uuu.moe');
UPDATE yashi_comments SET comment_content = replace(comment_content,'http://heartunlock.com','http://yashi.uuu.moe');
UPDATE yashi_comments SET comment_author_url = replace(comment_author_url,'http://heartunlock.com','http://yashi.uuu.moe');
UPDATE yashi_options SET option_value = replace( option_value, 'http://heartunlock.com','http://yashi.uuu.moe') WHERE option_name = 'home' OR option_name ='siteurl';

-- 替换所有文章内容：
UPDATE racing_posts SET post_content = replace(post_content,'https://www.r.com.cn/video/','https://video.r.com.cn/');

-- 批量转换协议
UPDATE yashi_posts SET post_content = replace(post_content,'http://','https://');
UPDATE yashi_comments SET comment_content = replace(comment_content,'http://','https://');
UPDATE yashi_comments SET comment_author_url = replace(comment_author_url,'http://','https://');
UPDATE yashi_options SET option_value = replace( option_value, 'http://','https://') WHERE option_name = 'home' OR option_name ='siteurl';