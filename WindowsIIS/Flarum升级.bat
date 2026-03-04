composer update --prefer-dist --no-plugins --no-dev -a --with-all-dependencies
@REM 如果提示 Package * is abandoned, you should avoid using it. Use fof/oauth instead. 先去 composer.json 移除提示的包
php flarum migrate
php flarum cache:clear