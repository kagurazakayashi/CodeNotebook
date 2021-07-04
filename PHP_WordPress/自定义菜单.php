wp_nav_menu()方法位于wp-includes/nav-menu-templates.php文件中。
其主要用途是通过该方法，实现后台的生成菜单调用。
使用该功能之前，必须激活主题3.0+菜单功能。
激活方法如下：

在functions.php文件中加入
<?php
if(function_exists('register_nav_menus')){
    register_nav_menus(
        array(
        'header-menu' => __( '导航自定义菜单' ),
        'footer-menu' => __( '页角自定义菜单' ),
        'sider-menu' => __('侧边栏菜单')
        )
    );
}
?>

简单调用如下：
<?php
wp_nav_menu(
    array(
        'theme_location'  => '' //指定显示的导航名，如果没有设置，则显示第一个
        'menu'            => 'header-menu',
        'container'       => 'nav', //最外层容器标签名
        'container_class' => 'primary', //最外层容器class名
        'container_id'    => '',//最外层容器id值
        'menu_class'      => 'sf-menu', //ul标签class
        'menu_id'         => 'topnav',//ul标签id
        'echo'            => true,//是否打印，默认是true，如果想将导航的代码作为赋值使用，可设置为false
        'fallback_cb'     => 'wp_page_menu',//备用的导航菜单函数，用于没有在后台设置导航时调用
        'before'          => '',//显示在导航a标签之前
        'after'           => '',//显示在导航a标签之后
        'link_before'     => '',//显示在导航链接名之后
        'link_after'      => '',//显示在导航链接名之前
        'items_wrap'      => '<ul id="%1$s">%3$s</ul>',
        'depth'           => 0,////显示的菜单层数，默认0，0是显示所有层
        'walker'          => ''//调用一个对象定义显示导航菜单
    )
);
?>

根据是否登录生成不同该菜单栏
<?php
if ( is_user_logged_in() ) {
     wp_nav_menu( array( 'theme_location' => 'logged-in-menu' ) );
} else {
     wp_nav_menu( array( 'theme_location' => 'logged-out-menu' ) );
}
?>

移除菜单栏
<?php
function my_wp_nav_menu_args( $args = '' )
{
	$args['container'] = false;
	return $args;
} // function
add_filter( 'wp_nav_menu_args', 'my_wp_nav_menu_args' );
?>

或者
<?php wp_nav_menu( array( 'container' => '' ) ); ?>
