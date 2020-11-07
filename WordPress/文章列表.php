<?php 
$args = array(
    'numberposts'    => 5,
    'offset'         => 0,
    'category'       => ,
    'orderby'        => 'post_date',
    'order'          => 'DESC',
    'include'        => ,
    'exclude'        => ,
    'meta_key'       => ,
    'meta_value'     => ,
    'post_type'      => 'post',
    'post_mime_type' => ,
    'post_parent'    => ,
    'post_status'    => 'publish'
);
$posts_array = get_posts($args);
$post_content = $posts_array[0]->post_content;
$title = $posts_array[0]->title;
$post_date = $posts_array[0]->post_date;
?>

orderby:

‘author’ —— 按作者数值编号排序
‘category’ —— 按类别数值编号排序
‘content’ —— 按内容排序
‘date’ —— 按创建日期排序
‘ID’ —— 按文章编号排序
‘menu_order’ —— 按菜单顺序排序。仅页面可用。
‘mime_type’ —— 按MIME类型排序。仅附件可用。
‘modified’ —— 按最后修改时间排序。
‘name’ —— 按存根排序。
‘parent’ —— 按父级ID排序
‘password’ —— 按密码排序
‘rand’ —— 任意排序结果
‘status’ —— 按状态排序
‘title’ —— 按标题排序
‘type’ —— 按类型排序

posts_array:

{
    "ID": 590,
    "post_author": "1",
    "post_date": "2020-06-28 18:13:30",
    "post_date_gmt": "2020-06-28 10:13:30",
    "post_content": "<p>正文</p>",
    "post_title": "标题",
    "post_excerpt": "",
    "post_status": "publish",
    "comment_status": "closed",
    "ping_status": "closed",
    "post_password": "",
    "post_name": "标题",
    "to_ping": "",
    "pinged": "",
    "post_modified": "2020-10-01 18:50:03",
    "post_modified_gmt": "2020-10-01 10:50:03",
    "post_content_filtered": "",
    "post_parent": 0,
    "guid": "http://xxxx/?p=xxx",
    "menu_order": 0,
    "post_type": "post",
    "post_mime_type": "",
    "comment_count": "0",
    "filter": "raw"
}