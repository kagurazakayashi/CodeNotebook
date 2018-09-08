<?php
这些常量在 PHP 的内核中定义。它包含 PHP、Zend 引擎和 SAPI 模块。

PHP_VERSION (string);
//当前PHP版本为 "major.minor.release[extra]"表示法中的字符串。

PHP_MAJOR_VERSION (integer);
//当前PHP“主要”版本作为整数 (e.g., int(5) from version "5.2.7-extra"). Available since PHP 5.2.7.

PHP_MINOR_VERSION (integer);
// 当前PHP“次要”版本为整数 (e.g., int(2) from version "5.2.7-extra"). Available since PHP 5.2.7.

PHP_RELEASE_VERSION (integer);
// 当前PHP“发布”版本为整数 (e.g., int(7) from version "5.2.7-extra"). Available since PHP 5.2.7.

PHP_VERSION_ID (integer);
// 当前PHP版本作为整数，对版本比较很有用 (e.g., int(50207) from version "5.2.7-extra"). Available since PHP 5.2.7.

PHP_EXTRA_VERSION (string);
// 当前PHP“额外”版本作为字符串 (e.g., '-extra' from version "5.2.7-extra"). Often used by distribution vendors to indicate a package version. Available since PHP 5.2.7.

PHP_ZTS (integer);
// Available since PHP 5.2.7.

PHP_DEBUG (integer);
// Available since PHP 5.2.7.

PHP_MAXPATHLEN (integer);
// 此PHP版本支持的文件名（包括路径）的最大长度。 Available since PHP 5.3.0.

PHP_OS (string);
// PHP的操作系统是为其构建的。

PHP_OS_FAMILY (string);
// PHP的操作系统系列是为其而构建的。 Either of 'Windows', 'BSD', 'Darwin', 'Solaris', 'Linux' or 'Unknown'. Available as of PHP 7.2.0.

PHP_SAPI (string);
// 这个PHP版本的服务器API。参见 php_sapi_name()。

PHP_EOL (string);
// The correct 'End Of Line' symbol for this platform.自 PHP 5.0.2 起可用

PHP_INT_MAX (integer);
// 这个PHP版本支持的最大整数。 通常 int(2147483647).自 PHP 5.0.5 起可用

PHP_INT_MIN (integer);
// 这个PHP版本支持的最小整数。通常在32位系统中为int（-2147483648），在64位系统中为int（-9223372036854775808）。从PHP 7.0.0开始提供。通常，PHP_INT_MIN === ~PHP_INT_MAX。

PHP_INT_SIZE (integer);
// 此PHP版本中的整数（以字节为单位）。 自 PHP 5.0.5 起可用

PHP_FLOAT_DIG (integer);
// 可以舍入到浮点数并返回而没有精度损失的小数位数。 Available as of PHP 7.2.0.

PHP_FLOAT_EPSILON (float);
// 最小的可表示正数x，因此 x + 1.0 != 1.0. Available as of PHP 7.2.0.

PHP_FLOAT_MIN (float);
// 最小的可表示浮点数。 Available as of PHP 7.2.0.

PHP_FLOAT_MAX (float);
// 最大可表示的浮点数。 Available as of PHP 7.2.0.

DEFAULT_INCLUDE_PATH (string);

PEAR_INSTALL_DIR (string);

PEAR_EXTENSION_DIR (string);

PHP_EXTENSION_DIR (string);

PHP_PREFIX (string);
The value "--prefix" was set to at configure.

PHP_BINDIR (string);
// 指定二进制文件的安装位置。

PHP_BINARY (string);
// 指定脚本执行期间的PHP二进制路径。 Available since PHP 5.4.

PHP_MANDIR (string);
// 指定联机帮助页的安装位置。 Available since PHP 5.3.7.

PHP_LIBDIR (string);

PHP_DATADIR (string);

PHP_SYSCONFDIR (string);

PHP_LOCALSTATEDIR (string);

PHP_CONFIG_FILE_PATH (string);

PHP_CONFIG_FILE_SCAN_DIR (string);

PHP_SHLIB_SUFFIX (string);
// 构建平台的共享库后缀，例如“so”（大多数Unix）或“dll”（Windows）。

PHP_FD_SETSIZE (string);
// 选择系统调用的最大文件描述符数。 Available as of PHP 7.1.0.

E_ERROR (integer);
E_WARNING (integer);
E_PARSE (integer);
E_NOTICE (integer);
E_CORE_ERROR (integer);
E_CORE_WARNING (integer);
E_COMPILE_ERROR (integer);
E_COMPILE_WARNING (integer);
E_USER_ERROR (integer);
E_USER_WARNING (integer);
E_USER_NOTICE (integer);
E_RECOVERABLE_ERROR (integer);
// Available since PHP 5.2.0
E_DEPRECATED (integer);
// Available since PHP 5.3.0
E_USER_DEPRECATED (integer);
// Available since PHP 5.3.0
E_ALL (integer);
E_STRICT (integer);
// 错误报告常量

__COMPILER_HALT_OFFSET__ (integer);
// 自 PHP 5.1.0 起有效

TRUE (boolean);
FALSE (boolean);
NULL (null);
?>
