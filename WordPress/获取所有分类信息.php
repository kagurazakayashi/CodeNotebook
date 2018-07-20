<?php
$cats = get_categories(array(
'parent'=>4,
'hide_empty'=>0
));
foreach ($cats as $category) {
    echo '<br>连接：'.get_category_link( $category->term_id );
    echo '<br>名：'.$category->name;
    echo '<br>描述:'. $category->description;
    echo '<br>文章数: '. $category->count;
}
?>

制作wordpress主题时，想要获取所有分类相关信息，可以通过get_categories()函数，该函数可以返回与查询参数相匹配的类别对象数组，该函数的变量与wp_list_categories()函数基本一致，且变量可被作为数组传递，也可在查询句法中被传递。
函数用法：
<?php $categories = get_categories( $args ); ?>

$args参数及默认值：
<?php
	$args = array(
		'type' => 'post',
		'child_of' => 0,
		'parent' => '',
		'orderby' => 'name',
		'order' => 'ASC',
		'hide_empty' => 1,
		'hierarchical' => 1,
		'exclude' => '',
		'include' => '',
		'number' => '',
		'taxonomy' => 'category',
		'pad_counts' => false
	);
?>

参数说明：
type
(字符)post和link 其中link在新版3.0以后已被弃用。
child_of
(整数)仅显示标注了编号的分类的子类。该参数无默认值。使用该参数时应将hide_empty参数设为false
parent
(整数)只显示某个父级分类以及下面的子分类(注：子分类只显示一个层级)。
orderby
(字符)将分类按字母顺序或独有分类编号进行排序。默认为按分类 编号排序包括ID(默认)和Name
order
(字符)为类别排序（升序或降序）。默认升序。可能的值包括asc(默认)和desc
hide_empty
(布尔值)触发显示没有文章的分类。默认值为true（隐藏空类别）。有效的值包括:1(true)和0(false)
hierarchical
(布尔值)
将子类作为内部列表项目(父列表项下)的层级关系。默认为true（显示父列表项下的子类）。有效值包括1 (true)和0(false)
exclude
(字符)除去分类列表中一个或多个分类，多个可以用逗号分开，用分类ID号表示
include
(字符)只包含指定分类ID编号的分类。多个可以用逗号分开，用分类ID号表示
number
(字符)将要返回的类别数量
pad_counts
(布尔值)通过子类中的项来计算链接或文章。有效值包括1(true)和0(false)，0为默认
taxonomy
(字符)返回一个分类法，这个是wordpress3.0版本后新添加的一个参数。返回的值包括category(默认)和taxonomy(一些新定义的分类名称)
示例：显示分类列表和分类描述以及包含的文章数目

<?php
	$args=array(
		'orderby' => 'name',
		'order' => 'ASC'
	);
	$categories=get_categories($args);
	foreach($categories as $category) {
		echo '<p>Category: <a href="' . get_category_link( $category->term_id ) . '" title="' . sprintf( __( "View all posts in %s" ), $category->name ) . '" ' . '>' . $category->name.'</a> </p> ';
		echo '<p> Description:'. $category->description . '</p>';
		echo '<p> Post Count: '. $category->count . '</p>';
	}
?>

内容转自磊子的博客，作者几年前翻译wordpress官方的。
来自 <http://www.boke8.net/wordpress-get_categories.html>
