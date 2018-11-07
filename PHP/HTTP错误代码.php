<?php
      header('HTTP/1.1 404 Not Found');
      header("status: 404 Not Found");
?>

如果你的php版本大于5.4的话，可以使用这个新增的方法
<?php
    http_response_code(404);
?>
