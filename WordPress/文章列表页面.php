<?php
/**
 * Template Name: Article List
 *
 */
get_header();
$order_by = 'comment_count';
$order = 'DESC'; // 升序还是降序，DESC表示降序，ASC表示升序
$posts_per_page = 10; // 每页显示多少篇文章
/**
 * 只显示或不显示某些目录下的文章,目录ID用逗号分隔，排除目录前面加-
 * 例如排除目录29和30下的文章, $cat = '-29,-30';
 * 只显示目录29和30下的文章, $cat = '29, 30';
 */
$cat = '';
// 获取该页面的标题和内容
global $post;
$post_title = $post->post_title;
$post_content = apply_filters('the_content', $post->post_content);
// 当前是第几页
$paged = (get_query_var('paged')) ? get_query_var('paged') : 1;
// 获取文章列表
$post_list = new WP_Query(
    "posts_per_page=" . $posts_per_page .
    "&orderby=" . $order_by .
    "&order=" . $order .
    "&cat=" . $cat .
    "&paged=" . $paged
);
// 获取文章总数
$total_posts = $post_list->found_posts;
// 显示文章列表
if ( $post_list->have_posts() ) : ?>
    <div class="entry-content">
        <ul class="article-list">
        <?php while ( $post_list->have_posts() ) : $post_list->the_post(); ?>
            <li>
                <!-- 带连接的文章标题 -->
                <span class="post-title">
                    <a href="<?php the_permalink(); ?>" title="<?php the_title(); ?>" target="_blank"><?php the_title(); ?></a>
                </span>
                <!-- 显示评论数 -->
                <span class="post-comment"><?php comments_number( '', '1条评论', '%条评论' ); ?></span>
                <!-- 显示发布日期 -->
                <span class="post-date"><?php echo esc_html( get_the_date() ); ?></span>
            </li>
        <?php endwhile; ?>
        </ul>
        <!-- 用 wp_pagenavi 插件 分页 -->
        <?php if ( function_exists('wp_pagenavi') ) wp_pagenavi( array('query' => $post_list) );  ?>
    </div><!-- .entry-content -->
    <!-- 文章列表显示结束 -->
<?php endif;
get_footer(); ?>

https://www.solagirl.net/wordpress-paged-article-list.html