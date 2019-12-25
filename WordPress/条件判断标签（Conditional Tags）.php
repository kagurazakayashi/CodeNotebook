<?php
// 所有的条件判断标签
// 所有的条件判断标签都会判断某个条件是否成立，然后返回 True 或者 False 。此外有些条件判断标签还可以使用一些参数进一步的判断，下面是所有的 WordPress 条件判断标签：

// 主页面（Main）
is_home();
// 判断当前页面是否是博客主页面。主页面通常是显示博客内容列表的首页，但是如果你在“后台”->“设置”->“阅读”中设置了静态首页和文章索引页面的话，当访问文章索引页面是返回 True。

// 首页（Front）
is_front_page();
// 判断当前页面是否是博客首页。首页和上面的主页面不同，首页可以是文章索引页面，也可以是你在“后台”->“设置”->“阅读”中设置的静态首页。

// 后台控制面板（Administration Panels）
is_admin();
// 判断当前页面是否是后台的控制面板（Dashboard）。

// 文章页面（Single Post）
is_single();
// 判断当前页面是否是一篇文章或者是附件页面或者自定义文章类型页面。注意，WordPress 中文章（Single）和页面（Page）是不同的概念。这个条件判断标签可以附加参数。

is_single( '17' );
// 判断当前文章是否是 id 为 17 的文章。

is_single( 'Irish Stew' );
// 判断当前文章的标题是否是 “Irish Stew”。

is_single( 'beef-stew' );
// 判断当前文章的别名（Slug）是否为 “beef-stew”。

is_single( array( 17, 'beef-stew', 'Irish Stew' ) );
// 传递多个参数需要使用数组。上面条件判断标签判断满足 id 为 17 、别名为 beef-stew、标题为 Irish Stew 任意一个条件文章被访问时返回 True。

is_single( array( 17, 19, 1, 11 ) );
// 判断多个文章的 id，用法同上。

is_single( array( 'beef-stew', 'pea-soup', 'chili' ) );
// 判断多个文章的别名，用法同上。

is_single( array( 'Beef Stew', 'Pea Soup', 'Chili' ) );
// 判断多个文章的标题，用法同上。

// 注意：这个函数对于传递的参数，并无法很明确的判断参数究竟是 id、文章标题或者是文章别名，如果参数为 17，当 id 为 17 的文章会返回 True，当 Slug 为 17 的文章也会返回 True。

// 置顶文章（Sticky Post）
is_sticky();
// WordPress 带有置顶文章的功能，使用这个标签判断是否为置顶文章，需要传递一个参数（通常为文章 id，用法同上）。如果不想传递参数，需要用在主循环（Loop）中，由主循环提供。通常的用法是在主循环输出文章索引列表的时候，使用 is_sticky() 判断当前文章是否为置顶文章，然后在置顶文章的 title 前面输出 “[置顶]” 之类的标志。

// 文章类型（Post Type）
get_post_type();
// 严格意义上，这并不是一个条件判断标签，它会返回当前文章注册的文章类型，并且可以通过类似 if ( 'book' == get_post_type() ) ... 来实现判断文章类型的功能。

is_singular();
// 判断是否满足 is_single、is_page 和 is_attachment 的任意一个条件，满足返回 True。可以测试所有的文章类型。

post_type_exists();
// 判断某个文章类型是否被注册了，需要传递一个文章类型参数。它并不是测试某文章是否属于某个文章类型。

is_post_type_hierarchical( $post_type );
// 如果 $post_type 在注册的时候设置了支持层次（ hierarchical support ）返回 True。例如：is_post_type_hierarchical( 'book' ) 。

is_post_type_archive();
// 判断是否在任何的自定义文章类型存档页面（post type archive）。

is_post_type_archive( $post_type );
// 判断是否在 $post_type 中符合条件的文章类型存档页面，$post_type 可以是一个单一的文章类型或者是一个文章类型数组。提示：如果想要应用文章类型存档功能，需要在注册文章类型的时候，将 has_archive 参数设置为 True。

// 评论相关（Comments）
is_comments_popup();
// 判断是否在评论弹出框的窗口中。

comments_open();
// 判断评论功能是否开启，必须用在主循环中。

pings_open();
// 判断文章 ping 功能是否开启，必须用在主循环中。

// 判断页面（Page）
// WordPress 中内置的有两种内容形式，一种是文章（Post）另一种是页面（Page），这里要判断的是页面，而不是指你网站的某个网页。

is_page();
// 判断当前页面是否为“页面”。

is_page( 42 );
// 判断当前页面是否是一个 ID 为 42 的页面。

is_page( 'About Me And Joe' );
// 判断当前页面是否是一个标题为 “About Me And Joe” 的页面。

is_page( 'about-me' );
// 判断当前页面是否是一个别名为 “about-me” 的页面。

is_page( array( 42, 'about-me', 'Aout Me And Joe' ) );
// 一次包含多种情况的判断，需要使用数组传递，用法同上。

?>
判断内容分页
在文章和页面中，有时候内容很多，在文章中插入 <!--nextpage--> 标签可以将内容分隔开分成不同的页面，并通过对应的函数获取分页的列表。下面的例子，可以判断当前是在第几个页面中，这样你就可以在某个页面中输出一些特别的信息（例如在第一个页面中，输出一个提示）。

例子1：

<?php
$paged = $wp_query->get( 'page' );

if ( ! $paged || $paged < 2 ) {
    // 这里是不带有分页或者是带有分页页面的第一页
} else {
   // 这里是带有分页的其他页面。
}
?>

例子2：

<?php
$paged = get_query_var( 'page' ) ? get_query_var( 'page' ) : false;
if ( $paged === false ) {
    // 这里是不带有分页或者是带有分页页面的第一页
} else {
   // 这里是带有分页的其他页面。
}
?>

判断子页面（sub-Pages）
WordPress 中的页面（page）是有父子级关系的，判断是否为子页面时，没有内置 is_subpage() 这样的函数，但是你可以使用下面的方法来判断。

方法1：

<?php
global $post;     // 下面代码需要用在主循环中，如果你在循环外使用，需要声明全局变量 $post

if ( is_page() && $post->post_parent ) {
    // 这是一个子页面
} else {
    // 这不是一个子页面
}
?>

建议将下面的方法2加入你的 functions.php 文件中，下面的 is_subpage() 函数的原理与方法1类似，但是可以返回当前页面父页面的 ID 或者是 false。

方法2：

<?php
function is_subpage() {
    global $post;                              // 获取页面的相关信息
    if ( is_page() && $post->post_parent ) {   // 判断是否有父页面
        return $post->post_parent;             // 如果有返回父页面的 ID
    } else {
        return false;                          // 如果没有返回 false
    }
}
?>

如果你经常需要判断子页面，强烈建议使用方法2。

如果需要判断父页面是否为某个特定的页面，可以使用方法3的代码。方法3代码会判断的更加详细，从而更加便于自定义和个性化（例如加一些图片）。

方法3：

<?php
if ( is_page( 'about' ) || '2' == $post->post_parent ) {
    // 这个页面是“about”页面，或者它的父页面是“about”
    $bannerimg = 'about.jpg';
} elseif ( is_page( 'learning' ) || '56' == $post->post_parent ) {
    $bannerimg = 'teaching.jpg';
} elseif ( is_page( 'admissions' ) || '15' == $post->post_parent ) {
    $bannerimg = 'admissions.jpg';
} else {
    $bannerimg = 'home.jpg'; // 如果都不满足的话，就用这个图片
}
?>

方法4是一个函数可以让你更容易的实现判断，只需要传递参数即可，如果正在访问对应页面，将会返回 True。

方法4：

<?php
function is_tree( $pid ) {      // $pid = 传递的 ID 参数是我们希望判断的页面 ID
    global $post;      

    if ( is_page($pid) )
        return true;            // 当前正在这个页面，所以返回 True

    $anc = get_post_ancestors( $post->ID );
    foreach ( $anc as $ancestor ) {
        if( is_page() && $ancestor == $pid ) {
            return true;
        }
    }

    return false;  // 没有在当前页面，并且这个页面没有子页面
}
?>

可以将这个函数添加进 functions.php 中，调用 is_tree( 'id' ) 就可以判断当前页面是否是指定页面或者是这个页面的子页面。相比较方法3 is_tree( '2' ) 的功能和 is_page( 'about' ) || '2' == $post->post_parent 是一样的。

注意，如果页面乘此多于一级，那么父级页面指的是上一层页面，不是这个页面层次关系最顶层的页面。

<?php
// 判断页面模版（Page Template）
// 判断当前页面是否由某个页面模版生成的，关于页面模版请看我爱水煮鱼上的：WordPress 教程：自定义页面（Page）的模板样式。

is_page_template();
// 判断是否使用了一个页面模版。

is_page_template( 'about.php' );
// 判断应用的页面模版是否是 “about” 这个模板。注意，这个参数与其他参数不同，如果你想判断是否是由某个页面模版声称的，你需要将那个页面模版的文件名填上去，包括后面的 .php 后缀。

// 判断分类页面（Category）
is_category();
// 判断当前页面是否为分类目录或者存档（archive）页面。

is_category( '9' );
// 判断当前分类页面的 ID 是否为 9。

is_category( 'Stinky Cheeses' );
// 判断当前分类页面的名字是否为“Stinky Cheeses”。

is_category( 'blue-cheese' );
// 判断当前分类页面的别名是否为“blue-cheese”。

is_category( array( 9, 'blue-cheese', 'Stinky cheeses' ) );
// 同上，你懂的。

in_category( '5' );
// 判断当前文章是否属于某个特定分类目录（id 为 5），返回 True。注意，这里是 in 而不是 is，与上面的不同。

in_category( array( 1,2,3 ) );
// 判断当前文章是否属于某些特定的分类目录。

// 判断标签页面（Tag）
is_tag();
// 判断当前页面是否为标签页面。

is_tag( 'mild' );
// 判断当前标签页面的别名是否为 “mild”。

is_tag( array( 'sharp', 'mild', 'extreme' ) );
// 判断当前标签页面的别名是否是 “sharp”、“mild”或者“extreme”中的某个。

has_tag();
// 判断当前文章是否有一个标签，必须用在主循环中。

has_tag( 'mild' );
// 判断当前文章是否有标签 “mild”。

has_tag( array( 'sharp', 'mild', 'extreme' ) );
// 判断当前文章是否有数组里的那些标签。

// 判断自定义分类页面（Taxonomy）
// 自定义分类页面并非是上面的 category 那种分类页面，而是指 WordPress 分类系统页面。在 WordPress 默认内置了两种分类系统：category 和 tag，同时支持开发者自定义分类系统。

is_tax();
// 判断当前页面是否为一个分类系统的存档页面。

is_tax( 'flavor' );
// 判断当前页面是否为一个名为 flavor 自定义分类的存档页面。

is_tax( 'flavor', 'mild' );
// 判断当前自定义分类 flavor 页面的别名是否为 mild。

is_tax( 'flavor', array( 'sharp', 'mild', 'extreme' ) );
// 判断当前自定义分类 flavor 页面的页面是否为 sharp、mild、extreme 中的一个。

has_term();
// 判断当前页面是否带有自定义分类。

has_term( 'green', 'color' );
// 判断当前页面是否是否带有别名为 green 的自定义分类 color。

has_term( array( 'green', 'orange', 'blue' ), 'color' );
// 判断当前页面是否是否带有数组中的自定义分类 color。

// 判断作者页面（Author）
is_author();
// 判断当前页面是否是一个作者存档页面。

is_author( '4' );
// 判断当前页面是否为 id 为 4 的作者页面。

is_author( 'Vivian' );
// 判断当前存档页面是否是 Vivian（Nickname） 的作者存档页面。

is_author( array( 4, 'john-jones', 'Vivian' ) );
// 判断当前存档页面是否属于 id 为 4，或者名字为 “john-jones”、“Vivian” 的作者存档页面。

is_multi_author();
// 判断当前博客是否有超过一个作者发表过文章。WordPress 3.2 以上版本可用。

// 判断是否为日期存档页面（Date Page）
is_date();
// 判断当前页面是否为任何的按时间存档的页面。

is_year();
// 判断当前页面是否为按年份存档的页面。

is_month();
// 判断当前页面是否为按月份存档的页面。

is_day();
// 判断当前页面是否为按日期存档的页面。

is_time();
// 判断当前页面是否为按照小时、分钟、秒存档的页面。

is_new_day();
// 判断当前页面是否为文章日期的新的一天，必须用在主循环中。

// 判断任意存档页面（Any Archive Page）
is_archive();
// 判断当前页面是否为一个存档页面，包括：分类、标签、作者页面、日期存档页面等。

// 判断搜索结果页面（Search Result Page）
is_search();
// 判断当前页面是否为一个搜索结果页面。

// 判断是否为 404 页面（404 Not Found Page）
is_404();
// 判断当前页面是否带有 “HTTP 404：Not Found” 错误。

// 判断被分页页面（Paged Page）
is_paged();
// 这里的分页指的是存档页面，如果一个日志或者静态页面的内容通过通过 <!--nextpage--> 拆分成多个页面，这些不能算为 paged page

// 判断是否为附件页面（Attachment）
is_attachment();
// 判断当前页面是否为一个附件页面。附件页面通常为一个图片或者是一些其他文件，可以在编辑文章上传文件那里进行设置。

// 判断单页面、文章页面或者附件页面
is_singular();
// 只要 is_single()、is_page()、is_attachment() 返回 True，此函数返回 True。

is_singular( 'book' );
// 判断当前文章是否属于自定义文章类型（Custom Post Types）“book”。

is_singular( array( 'newspaper', 'book' ) );
// 判断当前文章是否属于数组中某个自定义文章类型。

// 判断订阅页面
is_feed();
// 判断是否在订阅输出的页面。这个判断标签是为插件开发者提供的。

// 判断引用通告（Trackback）
is_trackback();
// 判断当前 WordPress 主题是否开启了 Trackback 功能。这个判断标签是为开发者提供的。

// 判断预览页面
is_preview();
// 判断一篇文章是否在预览（文章本身处于草稿状态）。

// 判断是否有摘要
has_excerpt();
// 判断当前文章是否有摘要内容。

has_excerpt( 42 );
// 判断文章 ID 为 42 的文章是否有摘要内容。
?>

还可以使用下面代码来实现：

<?php
// 先获取全局变量 $post
global $post;

if ( empty( $post->post_excerpt ) ) {
    // 如果文章没有摘要执行这块代码
} else {
    // 如果文章带有摘要执行这块代码
}
?>

如果你想在文章没有摘要的时候，显示空内容：

<?php if ( ! has_excerpt() ) {
    echo '';
} else {
    the_excerpt();
}
?>

<?php
// 判断是否有可用的自定义导航菜单
has_nav_menu();

// 判断一个被注册过的自定义导航菜单是否被指定了一个菜单。

// 判断是否在主循环中
in_the_loop();
// 判断是否在主循环内部。对开发者来说很有用。

// 判断边栏是否已经激活可用
is_active_sidebar();
// 判断给出的边栏是否激活（正在使用）。如果边栏（用 name、id、number 标志）正在使用，就会返回 True。

// 判断是否是网站的一部分（对于多站点网站）
is_multisite();
// 判断当前的站点是否是 WordPress MultiSite 的一部分。

// 判断是否是主站点（对于多站点网站）
is_main_site();
// 判断当前站点在整个网络中，是否是主站点。

// 判断网站的 Admin （对于多站点网站）
is_super_admin();
// 判断当前用户是否是整个网站中的管理员。

// 判断插件是否激活
is_plugin_active();
// 判断某个插件是否激活正在使用。

// 判断子主题
is_child_theme();
// 判断当前是否是一个正在使用的子主题。

// 判断当前主题功能
current_theme_supports();
// 判断当前主题的功能特性是否存在。

// 使用条件判断标签的实例
// 下面给出一些例子，让你明白上面的判断标签如何使用。

// 文章中的条件判断
// 下面的例子讲述了当用户访问一篇文章的时候如何使用 is_single() 来显示一些特殊的内容。

if ( is_single() ) {
    echo 'This is just one of many fabulous entries in the ' . single_cat_title() . ' category!';
}
// 下面的例子介绍了如何在主循环中使用条件判断语句。功能是在首页（index）中显示文章的摘要，而在文章（single）和主页（home）中显示文章的正文内容。

if ( is_home() || is_single() ) {
    the_content();
}
else {
    the_excerpt();
}
// 同时使用多个条件判断标签
// 使用常见的 PHP 操作符 就可以使用多个条件判断标签。

// 同时判断两个条件
if ( is_single() || is_page() ) {
// 如果当前是一篇文章或者一个页面，就执行这块代码
}

if ( is_archive() && ! is_category( 'nachos' ) ) {
// 如果当前是一个分类的存档页面（除了 nachos 分类），就执行这块代码
}

// 同时判断三个条件
if ( $query->is_main_query() && is_post_type_archive( 'products' ) && ! is_admin() ) {
	// 如果当前是 main query 并且是 products 自定义文章类型的存档页面
	// 同时没有用 admin 账号登陆后台，就执行这块代码
}

if ( is_post_type_archive( 'movies' ) || is_tax( 'genre' ) || is_tax( 'actor' )  ) {
	// 如果当前是 Movies 的自定义文章类型存档
	// 或者是 genre 分类存档页面
	// 或者是 actor 分类存档页面，就执行这块代码
}
?>

https://blog.wpjam.com/article/wordpress-conditional-tags/