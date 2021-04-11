# 在typescript+Vue的项目中引用echarts

## 为了加强引用，引入echarts和@types/echarts两个包，一个是工程依赖，一个是声明依赖。

- `npm install echarts --save`
- `npm install --save @types/echarts`

# 然后在需要引用echarts的组件中引入echarts

```
<script lang="ts">
……
import echarts from 'echarts';
……
</script>
```

# 然后设置好option选项，将图表渲染在DOM里：

## HTML部分
`<div ref="chart"></div>`

## Script部分
```
option={};
const Chart = echarts.init(this.$refs.chart as HTMLCanvasElement);
Chart.setOption(this.option);
```