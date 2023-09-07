## 说明
TinyMCE 是一个富文本编辑器，允许用户在用户友好的界面中创建格式化内容。

- 官网：[Tiny](https://www.tiny.cloud/)
- 文档：[Docs.Vue](https://www.tiny.cloud/docs/tinymce/6/vue-pm/)
- 控制台：[Tiny.cloud](https://www.tiny.cloud/auth/login/)

## 安装
- Vue.js 3.x
```
npm install --save tinymce "@tinymce/tinymce-vue@^5"
```
- Vue.js 2.x
```
npm install --save tinymce "@tinymce/tinymce-vue@^3"
```
## 引入
```
import Editor from '@tinymce/tinymce-vue'
```
## 使用
```
<Editor
    api-key="no-api-key"
    :init="{
    plugins: 'lists link image table code help wordcount'
    }"
/>
```