// flutter pub add cached_network_image
CachedNetworkImage(
    imageUrl: 'https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png',
    imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            ),
        ),
    ), // imageBuilder 圆角用
    placeholder: (context, url) => const CircularProgressIndicator(), // 转圈等待
    errorWidget: (context, url, error) => Image.asset(
        'images/null.png',
    ), // 错误返回图片，也可返回图标 const Icon(Icons.error)
)