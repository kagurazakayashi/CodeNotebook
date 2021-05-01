var gulp = require('gulp');
//压缩需要的插件，引入
var uglify = require('gulp-uglify');
var css = require('gulp-clean-css');
var html = require('gulp-htmlmin');

gulp.task('jscompress', async () => {
    await gulp.src('./src/*.js') //获取文件流
        .pipe(uglify()) //执行压缩
        .pipe(gulp.dest('dist/js')) //输出到文件
});
//压缩js

gulp.task('css', async () => {
    await gulp.src('./src/*.css')
        .pipe(css())
        .pipe(gulp.dest('./dist/'))
})
//压缩css

gulp.task('html', async () => {
    await gulp.src('*.html')
        .pipe(html())
        .pipe(gulp.dest('./dist/'))
})
//压缩html