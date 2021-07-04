wp_list_categories 函数 是 WordPress 中用来罗列系统中分类链接的函数，将分类以列表的形式显示为链接。点击分类的链接，就可以访问该分类下的所有文章的存档页面。
注意：
1、 wp_list_categories() 和 list_cats() 以及 wp_list_cats() 的使用类似，但是后面 2 个已经弃用。
2、如果你希望不格式化输出分类，请使用 get_categories()
3、因为 WordPress 中内置扩展的小工具功能，所以我们不经任何函数就可以在边栏或是其他我们想要的位置显示一个分类列表，所以wp_list_categories函数就很少有人用到。
4、该函数使用起来有点类似于wp_list_bookmarks()
5、该函数输出 应当包含在 ul 标签内

使用方法
<?php wp_list_categories( string|array $args = '' ); ?>

默认用法
<?php
$args = array(
    'show_option_all'  => '',//是否列出分类链接
    'orderby'      => 'name',//按名称排列
    'order'       => 'ASC',//升、降序
    'style'       => 'list',//是否用列表（ul>li）
    'show_count'     => 0,//是否显示文章数量
    'hide_empty'     => 1,//是否显示无日志分类
    'use_desc_for_title' => 1,//是否显示分类描述
    'child_of'      => 0,//是否限制子分类
    'feed'        => '',//是否显示rss
    'feed_type'     => '',//rss类型
    'feed_image'     => '',//是否显示rss图片
    'exclude'      => '',//排除分类的ID，多个用',（英文逗号）'分隔
    'exclude_tree'    => '',//排除分类树，即父分类及其下的子分类
    'include'      => '',//包括的分类
    'hierarchical'    => true,//是否将子、父分类分级
    'title_li'      => __( 'Categories' ),//列表标题的名称
    'show_option_none'  => __('No categories'),//无分类时显示的标题
    'number'       => null,//显示分类的数量
    'echo'        => 1,//是否显示，显示或者返回字符串
    'depth'       => 0,//层级限制
    'current_category'  => 0,//添加一个没有的分类
    'pad_counts'     => 0,//这个我也不明白
    'taxonomy'      => 'category',//使用的分类法
    'walker'       => null//用于显示的类
);
wp_list_categories( $args );
?>

用法举例

1、包含或排除某分类
意思就是把分类ID为3，5，9，16的分类按名称顺序来排序：
<?php wp_list_categories('orderby=name&include=3,5,9,16'); ?>
或者:
<ul>
<?php wp_list_categories( array(
    'orderby' => 'name',
    'include' => array( 3, 5, 9, 16 )
) ); ?>
</ul>

3、显示或隐藏列表标题
过滤ID为4和7的分类，并且列表标题设置为“511遇见”：
<?php wp_list_categories('exclude=4,7&title_li=511遇见'); ?>

4、列表中只显示ID为5、9、23的分类，并把列表标题改为 Poetry （下面的格式是为了把“要显示的数据”和“标签参数区分开来”）
<?php wp_list_categories('include=5,9,23&title_li=<h2>' . __('Poetry') . '</h2>' ); ?>
或者:
<ul>
    <?php wp_list_categories( array(
        'include'  => array( 5, 9, 23 ),
        'title_li' => '<h2>' . __( 'Poetry', 'textdomain' ) . '</h2>'
    ) ); ?>
</ul>
title_li参数设置或隐藏一个标题或标题wp_list_categories生成的类别列表。它默认为”(__(类别)”,即它显示这个词“类别”列表的标题。如果这个参数设置为null或空值,不显示标题。下面的示例代码不包括类别id 4和7和隐藏列表标题:
<ul>
    <?php wp_list_categories( array(
        'exclude'  => array( 4,7 ),
        'title_li' => ''
    ) ); ?>
</ul>

5、只显示指定分类的子分类
显示ID为 8 的分类的子分类，根据ID排序，显示文章数，并且将分类描述作为连接的 title属性。注意：如果父分类没有文章，将不显示父分类。
<ul>
   <?php wp_list_categories('orderby=id&show_count=1&use_desc_for_title=0&child_of=8'); ?>
</ul>
或者:
<ul>
    <?php wp_list_categories( array(
        'orderby'            => 'id',
        'show_count'         => true,
        'use_desc_for_title' => false,
        'child_of'           => 8
    ) ); ?>
</ul>

6、移除分类计数的括号
当 show_count=1 ，每个分类的后面都将显示文章数，同时使用括号包含。如果你要移除括号，可以使用下面的代码
<ul>
<?php
$variable = wp_list_categories( array(
    'echo' => false,
    'show_count' => true,
    'title_li' => '<h2>' . __( 'Categories', 'textdomain' ) . '</h2>'
) );
 
$variable = preg_replace( '~\((\d+)\)(?=\s*+<)~', '$1', $variable );
echo $variable;
?>
</ul>

7、显示分类和 RSS Feed 连接
根据分类名称进行排序，显示文章数量，并且显示每个分类的 RSS 订阅链接：
<ul>
<ul>
    <?php wp_list_categories( array(
        'orderby'    => 'name',
        'show_count' => true,
        'feed'       => 'RSS'
    ) ); ?>
</ul>
</ul>
使用Feed 图标替换文本，可以使用下面的代码：
<ul>
    <?php wp_list_categories( array(
        'orderby'    => 'name',
        'show_count' => true,
        'feed_image' => '/images/rss.gif'
    ) ); ?>
</ul>

显示自定义分类法的项目：
在3.0版本添加了taxonomy 参数到  wp_list_categories() 。让你可以通过 taxonomy 参数来设置要显示的是哪种分类法下的分类项目。比如要显示分类法为 genre 的分类列表：
<?php
// List terms in a given taxonomy using wp_list_categories (also useful as a widget if using a PHP Code plugin)
 
$taxonomy     = 'genre';
$orderby      = 'name';
$show_count   = false;
$pad_counts   = false;
$hierarchical = true;
$title        = '';
 
$args = array(
  'taxonomy'     => $taxonomy,
  'orderby'      => $orderby,
  'show_count'   => $show_count,
  'pad_counts'   => $pad_counts,
  'hierarchical' => $hierarchical,
  'title_li'     => $title
);
?> 
<ul>
    <?php wp_list_categories( $args ); ?>
</ul>

显示文章对应的分类：
根据父-子关系来排序文章的分类。类似于 get_the_category_list() 函数（根据名称排序分类）。这个例子必须使用内循环。
<?php
$taxonomy = 'category';
 
// Get the term IDs assigned to post.
$post_terms = wp_get_object_terms( $post->ID, $taxonomy, array( 'fields' => 'ids' ) );
 
// Separator between links.
$separator = ', ';
 
if ( ! empty( $post_terms ) && ! is_wp_error( $post_terms ) ) {
 
    $term_ids = implode( ',' , $post_terms );
 
    $terms = wp_list_categories( array(
        'title_li' => '',
        'style'    => 'none',
        'echo'     => false,
        'taxonomy' => $taxonomy,
        'include'  => $term_ids
    ) );
 
    $terms = rtrim( trim( str_replace( '<br />',  $separator, $terms ) ), $separator );
 
    // Display post categories.
    echo  $terms;
}
?>

标记和样式化分类列表
默认情况下， wp_list_categories() 生成的是无序列表（ul），使用 li 标签来包含每个分类，而且列表的标题为"Categories"。
你可以通过设置 title_li 为空值来隐藏标题。你可以自定义包装 有序列表或无序列表。如果你不需要以列表输出分类，可以将 style 参数设置为 none。
你可以根据下面的CSS选择器来样式化输出：
<style>
li.categories { ... }  /* outermost list item */
li.cat-item { ... }
li.cat-item-7 { ... }  /* category ID #7, etc */
li.current-cat { ... }
li.current-cat-parent { ... }
ul.children { ... }
</style>

小结
1、官方文档：https://developer.wordpress.org/reference/functions/wp_list_categories/
2、因为我们没有必要再使用这个函数，最让我们心动的就是最后这个CSS的改变，这样可以让你更灵活的显示在前台，比如有人问，如何去掉函数中封装的 li 标签，这样问的原因我猜主要是它的布局不是采用了 li 标签，或者一些样式加布进去，所以你多多研究一下总后一个例子还是很有必要的。
3、如何去掉li
<?php wp_list_categories('style=none'); ?>
