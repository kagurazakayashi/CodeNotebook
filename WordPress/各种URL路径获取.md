在wordpress插件和主题开发中经常需要获取各种URL路径，wordpress提供了以下集中方法获得URL路径：

- `plugins_url()` — 插件目录的 URL (例如：http://www.hujuntao.com/wp-content/plugins)
- `includes_url()` — includes 目录的 URL (例如：http://www.hujuntao.com/wp-includes)
- `content_url()` — content 目录的 URL (例如：http://www.hujuntao.com/wp-content)
- `admin_url()` — admin 目录的 URL (例如：http://www.hujuntao.com/wp-admin/)
- `site_url()` — 当前网站的 URL (例如：http://www.hujuntao.com)
- `home_url()` — 当前网站首页的 URL (例如：http://www.hujuntao.com)

要获得首页地址有很多方法：site_url()、home_url()、bloginfo(‘url’)、get_bloginfo(‘url’)、get_site_url()、get_home_url()。它们之间有什么区别呢？

# 首先来认识下 site_url() 和 home_url() 这两个函数

`site_url()` 和 `home_url()` 很相似，容易混淆。

`site_url()` 返回的是数据库中 wp_options 表里面的 siteurl 字段值。这是指向 WordPress 核心文件的 URL,也就是你的wordpress安装路径。如果你的 WordPress 核心文件在你的服务器的子目录中，比如 /wordpress，那么 site_url() 的值就会是 http://www.uedsc.com/tag/wordpress 。在控制面板==>> 设置 ==>> WordPress 地址（URL）修改。（在非不得已的情况下不要修改，一般在安装成功后这个值是自动生成。修改错误的地址会导致页面打不开，后台管理也进不去，出现这种情 况只能通过修改数据库来修复。）

`home_url()` 则从 wp_option 表中取得 home 字段的值。这个地址是你希望访问你的 WordPress 网站的 URL 地址。例如，你的 WordPres 核心文件放在 /wordpress 目录下，但是你希望你的 URL是 http://www.uedsc.com，那么就要把 home 的值设置成 http://www.hujuntao.com。在控制面板==>> 设置 ==>> 站点地址（URL）。

如果你的博客安装在跟目录这个两个函数获得的值就是一样的，在插件和主题开发中为了使用中得到兼容，所以在选择的时候需要慎重。

总的来讲

- `home_url()` 就是首页地址，主要用在需要返回首页的时候。比如logo的链接，“首页”链接等等。
- `site_url()` wordpress安装路径，主要用在获得本地文件路径。

# bloginfo() 函数参数使用

bloginfo用于获得博客的相关信息，包括主页，安装路径地址。

下面是bloginfo()的可用参数：

- name                 = Testpilot
- description          = Just another WordPress blog
- admin_email          = admin@example
- url                  = http://example/home
- wpurl                = http://example/home/wp
- stylesheet_directory = http://example/home/wp/wp-content/themes/child-theme
- stylesheet_url       = http://example/home/wp/wp-content/themes/child-theme/style.css
- template_directory   = http://example/home/wp/wp-content/themes/parent-theme
- template_url         = http://example/home/wp/wp-content/themes/parent-theme
- atom_url             = http://example/home/feed/atom
- rss2_url             = http://example/home/feed
- rss_url              = http://example/home/feed/rss
- pingback_url         = http://example/home/wp/xmlrpc.php
- rdf_url              = http://example/home/feed/rdf
- comments_atom_url    = http://example/home/comments/feed/atom
- comments_rss2_url    = http://example/home/comments/feed
- charset              = UTF-8
- html_type            = text/html
- language             = en-US
- text_direction       = ltr
- version              = 3.1

其中

- bloginfo(‘url’) = 首页地址；
- bloginfo(‘wpurl’) = wordpress安装路径；

弄懂这个函数剩下的就简单了。

wordpress的bloginfo()和get_bloginfo()功能差不多，都是显示用户博客的相关信息，这些信息通常来自用户在 WordPress网站后台“我的配置”和“设置>常规”菜单中填写的内容。 区别就是bloginfo()把结果直接输出，可以用在页面模板的任何区域内；而get_bloginfo()则是返回一个数据！

- 当你需要返回值的时候则用 get_site_url()、get_bloginfo(‘url’)、get_home_url();
- 如果你想直接输出值则用 site_url()、bloginfo(‘url’)、home_url()；

# 下面我们来总结一下：

- 获得首页地址 ==> home_url()、bloginfo(‘url’)、get_bloginfo(‘url’)、get_home_url()；home_url() 3.0加入的函数，为了兼容老版本推荐使用bloginfo();
- 获得安装路径 ==> site_url()、bloginfo(‘wpurl’)、get_bloginfo(‘wpurl’)、get_site_url()；
- 如果你需要返回值 ==> get_bloginfo(‘url’)、get_home_url()/get_bloginfo(‘wpurl’)、get_site_url()；
- 如果你想直接输出值 ==>bloginfo(‘url’)、home_url()/bloginfo(‘wpurl’)、site_url()；
