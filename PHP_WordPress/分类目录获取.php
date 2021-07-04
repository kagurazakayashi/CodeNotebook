<?php
ini_set('display_errors', '1');
function archiveextend($cat_ID) {
echo "<h1>装入分类目录扩展：服务案例。</h1>".$cat_ID;
//echo category_description(5);
$cats = get_categories(array(
'parent'=>4,
'hide_empty'=>1
));
foreach ($cats as $category) {
echo '<br>- 分类链接：'.get_category_link( $category->term_id );
echo '<br>分类名：'.$category->name;
        echo '<br>分类描述:'. $category->description;
        echo '<br>分类文章数: '. $category->count;
}
if ($cat_ID == 4) {
echo "：不能访问主目录";
return;
}
if (have_posts()) : while (have_posts()) : the_post();
echo '<br>文章标题：'.get_the_title();
$contenttxt = preg_replace('/<img.*? \/>/','',get_the_content());
$contentimg = catch_that_image();
echo '<br>文章信息：'.$contenttxt;
echo '<br>文章图片：'.$contentimg;
endwhile; else :
//没有
endif;
}
?>
