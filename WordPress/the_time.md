# 用法

- `the_time()`
- `get_the_time()`

`<span class="date"><?php the_time('Y 年 n 月 j 日'); ?>&emsp;<?php the_time('G:i'); ?></span>`

# 参数

## 年
|     | 参数描述 | 输出效果 |
| --- | -------- | -------- |
| `y` | 显示后面 2 位数字 | `03` |
| `Y` | 显示 4 位数字 | `2003` |

## 月
|     | 参数描述 | 输出效果 |
| --- | -------- | -------- |
| `m` | 数字的，有前缀 0 | `06`、`12` |
| `n` | 数字的，没有前缀 0 | `6`、`12` |
| `F` | 月份全称（根据网站的语言是中文还是英文） | `一月`、`十二月`（`January`、`December`） |
| `M` | 月份简写（根据网站的语言是中文还是英文） | `一`、`十二`（`Jan`、`Dec`） |

## 日
|     | 参数描述 | 输出效果 |
| --- | -------- | -------- |
| `d` | 数字的，有前缀 0 | `01`、`31` |
| `j` | 数字的，没有前缀 0 | `1`、`31` |
| `S` | 序列型数字的后缀 | `st`、`nd`、`rd` 或 `th` |

## 时间
|     | 参数描述 | 输出效果 |
| --- | -------- | -------- |
| `a` | 小写上下午（根据网站的语言是中文还是英文） | `am`、`pm`（`上午`、`下午`） |
| `A` | 大写上下午（根据网站的语言是中文还是英文） | `AM`、`PM`（`上午`、`下午`） |
| `g` | 小时，12 小时制，没有前缀 0 | `6`、`12` |
| `h` | 小时，12 小时制，有前缀 0 | `06`、`12` |
| `G` | 小时，24 小时制，没有前缀 0 | `6`、`23` |
| `H` | 小时，24 小时制，有前缀 0 | `06`、`23` |
| `i` | 分，有前缀 0 | `01`、`59` |
| `s` | 秒，有前缀 0 | `01`、`59` |
| `T` | 时区/时间缩写 | `CST`、`EST`、`MDT`... |
| `O` | 时区 | `+0800` |
| `W` | 周数 | `22` |
| `z` | 天数 | `365` |

## 星期
|     | 参数描述 | 输出效果 |
| --- | -------- | -------- |
| `l` | 星期全称(小写字母 L)（根据网站的语言是中文还是英文） | `星期一`、`星期日`（`Monday`、`Sunday`） |
| `D` | 星期（根据网站的语言是中文还是英文） | `周一`、`周日`（`Mon`、`Sun`） |
| `w` | 数字星期 | `0`、`6`（注意：0 代表星期日） |

## 完整的日期时间
|     | 参数描述 | 输出效果 |
| --- | -------- | -------- |
| `r` | RFC 2822 | `Mon, 06 Jan 2010 20:05:09+0800` |
| `c` | ISO 8601 | `2004-02-12T15:19:21+00:00` |

# 举例
|        代码         |                  显示                 |
| ------------------- | ------------------------------------- |
| `Y-m-d`             | `2013-05-09`                          |
| `G:i:s`             | `10:35:28`                            |
| `Y年m月d日`         | `2013 年 05 月 09 日`                 |
| `Y年m月d日 l`       | `2013 年 05 月 09 日`                 |
| `Y年m月d日 l G:i:s` | `2013 年 05 月 09 日 星期二 10:35:28` |

# 禁止自动转换成中文
`<?php the_time('M'); ?>`

改为

`<?php echo date('M',get_the_time('U')); ?>`