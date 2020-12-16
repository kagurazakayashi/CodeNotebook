-- 创建全文索引
ALTER TABLE `pagestable` ADD FULLTEXT (`page`) WITH PARSER ngram;
-- WITH PARSER ngram : 建立中文分词功能

-- 全文搜索

-- 自然语言模式
SELECT * FROM articles
WHERE MATCH (title,body)
AGAINST ('一路 一带' IN NATURAL LANGUAGE MODE);

-- 不指定模式，默认使用自然语言模式
SELECT * FROM articles
WHERE MATCH (title,body)
AGAINST ('一路 一带');

-- 获取相关性的值
SELECT id,title,
MATCH (title,body) AGAINST ('手机' IN NATURAL LANGUAGE MODE) AS score
FROM articles
ORDER BY score DESC;

-- 获取匹配结果记录数
SELECT COUNT(*) FROM articles
WHERE MATCH (title,body)
AGAINST ('一路 一带' IN NATURAL LANGUAGE MODE);

-- 使用BOOLEAN模式执行高级查询

-- 必须包含"腾讯"
SELECT * FROM articles
WHERE MATCH (title,body)
AGAINST ('+腾讯' IN BOOLEAN MODE);

-- 必须包含"腾讯"，但是不能包含"通讯工具"
SELECT * FROM articles
WHERE MATCH (title,body)
AGAINST ('+腾讯 -通讯工具' IN BOOLEAN MODE);

-- 'apple banana' 
-- 无操作符，表示或，要么包含apple，要么包含banana

-- '+apple +juice'
-- 必须同时包含两个词

-- '+apple macintosh'
-- 必须包含apple，但是如果也包含macintosh的话，相关性会更高。

-- '+apple -macintosh'
-- 必须包含apple，同时不能包含macintosh。

-- '+apple ~macintosh'
-- 必须包含apple，但是如果也包含macintosh的话，相关性要比不包含macintosh的记录低。

-- '+apple +(>juice <pie)'
-- 查询必须包含apple和juice或者apple和pie的记录，但是apple juice的相关性要比apple pie高。

-- 'apple*'
-- 查询包含以apple开头的单词的记录，如apple、apples、applet。

-- '"some words"'
-- 使用双引号把要搜素的词括起来，效果类似于like '%some words%'，
-- 例如“some words of wisdom”会被匹配到，而“some noise words”就不会被匹配。

-- https://www.jianshu.com/p/c48106149b6a