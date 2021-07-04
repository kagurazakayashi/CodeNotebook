<?php
// WordPress常用到的一些路径和 url 地址的调用，包括站点根目录路径、主题目录路径、插件目录路径等。

// 站点路径相关函数
home_url();

// 返回站点路径，相当于后台设置->常规中的”站点地址（URL）”。
$url = home_url();
echo $url;
//输出: http://www.seo628.com

$url = home_url('/images/');
echo $url;
//输出：http://www.seo628.com/images/
site_url();

// 如果 WordPress 安装在域名根目录下，则该函数与 home_url()相同。

// 如果 WordPress 安装在子目录下，例如http://www.seo628.com/，则site_url()返回 WordPress 实际安装地址，相当于后台->设置->常规中的“WordPress 地址（URL）”。

$url = site_url();
echo $url;
//假设 WordPress 安装在 http://www.seo628.com 下
//输出：http://www.seo628.com

admin_url();
// 返回后台地址，传递参数后也可返回后台 menu 的地址

$url = admin_url();
echo $url;
//输出：http://www.seo628.com/wp-admin/

content_url();
// 返回实际的 wp-content 目录，如果是默认安装，且装在根目录下，则如下所示

$url = content_url();
echo $url;
//输出：http://www.seo628.com/wp-content

includes_url();
// 返回当前 WordPress 站点存放核心文件的目录wp-includes的地址，可以带一个$path作为参数。

$url = includes_url( '/js/');
echo $url;
//输出：http://www.seo628.com/wp-includes/js/

wp_upload_dir();
// 返回 WordPress 上传目录的地址，是一个数组，包含一系列与上传地址相关的信息。

$upload_dir = wp_upload_dir();
// 提供如下信息给你

// ‘path’ – 上传目录的服务器绝对路径，通常以反斜杠（/）开头
// ‘url’ – 上传目录的完整 URL
// ‘subdir’ – 子目录名称，通常是以年/月形式组织的目录地址，例如/2016/05
// ‘basedir’ – 上传目录的服务器绝对路径，不包含子目录
// ‘baseurl’ – 上传目录的完整 URL，不包含子目录
// ‘error’ – 报错信息.
// 例如
$upload_dir = wp_upload_dir();
echo $upload_dir['baseurl'];
//输出：http://www.seo628.com/wp-content/uploads

// 主题路径相关函数
get_theme_root_uri();

// 获取存放主题的目录 URI
echo get_theme_root_uri();
//输出：http://www.seo628.com/wp-content/themes

get_theme_root();
// 获取存放主题的目录的服务器绝对路径

echo get_theme_root();
//输出：/home/user/public_html/wp-content/themes

get_theme_roots();
// 获取主题目录的目录名称，如果你的主题目录是/wp-content/themes，则
echo get_theme_roots();
//输出：/themes
get_stylesheet_directory();

// 获取当前启用的主题目录的服务器绝对路径，例如
// /home/user/public_html/wp-content/themes/twentyeleven
// 可以用来 include 文件，例如
include( get_stylesheet_directory() . ‘/includes/myfile.php’);

get_stylesheet_directory_uri();
// 获取当前启用的主题目录的 URI，例如
echo get_stylesheet_directory_uri();
//输出：http://www.seo628.com/wp-content/themes/twentyeleven
// 可以使用在需要主题目录 URI 的场合。

get_stylesheet();
// 获取当前启用主题的主题目录名称，与get_template()的区别是，如果用了 child theme，则返回 child theme 的目录名称。

// 插件路径相关函数
plugins_url();
// 获取当前插件的目录的 URI，例如一个插件位于/wp-content/plugins/myplugin下，该目录下放有插件的主文件名为myplugin.php，在myplugin.php中执行下面的代码，结果如下

echo plugins_url();
//输出：http://www.seo628.com/wp-content/plugins

echo plugins_url('',__FILE__);
//输出：http://www.seo628.com/wp-content/plugins/myplugin

echo plugins_url('js/myscript.js',__FILE__);
//输出：http://www.seo628.com/wp-content/plugins/myplugin/js/myscript.js
plugin_dir_url();

// 返回当前插件的目录 URI，例如

echo plugin_dir_url(__FILE__ );
//输出：http://www.seo628.com/wp-content/plugins/myplugin/
// 注意结尾有反斜杠。

plugin_dir_path();
// 返回当前插件目录的服务器绝对路径，例如
echo plugin_dir_path(__FILE__ );
//输出：/home/user/public_html/wp-content/plugins/myplugin/
// 可以用来引用文件，例如
define('MYPLUGINNAME_PATH', plugin_dir_path(__FILE__) );
require MYPLUGINNAME_PATH . 'includes/class-metabox.php';
require MYPLUGINNAME_PATH . 'includes/class-widget.php';

plugin_basename();
// 返回调用该函数的插件文件名称（包含插件路径）
// 例如在插件myplugin下的myplugin.php文件中调用该函数，结果如下
echo plugin_basename(__FILE__);
//输出：myplugin/myplugin.php
// 如果在myplugin/include/test.php文件中调用（test.php通过include引用到myplugin.php中），结果如下

echo plugin_basename(__FILE__);
//输出：myplugin/include/test.php

// Url 路径相关常量

// WordPress 中还有一组用define定义的常量代表路径。

echo WP_CONTENT_DIR;
// wp-content 目录的服务器绝对路径，例如
// /home/user/public_html/wp-content

echo WP_CONTENT_URL;
// wp-content 目录的 URI 地址，例如
// http://www.seo628.com/wp-content

echo WP_PLUGIN_DIR;
// 插件目录的服务器绝对路径，例如
// /home/user/public_html/wp-content/plugins

echo WP_PLUGIN_URL;
// 插件目录的 URI 地址，例如
// http://www.seo628.com/wp-content/plugins


// http://www.seo628.com/3306.html