<?php
    $thumbnail_id = get_post_thumbnail_id($post->ID);
    //thumbnail,medium,large,full,[320,240]
    $thumbnail_image_url = wp_get_attachment_image_src($thumbnail_id , 'thumbnail');
    var_dump($thumbnail_image_url);
?>