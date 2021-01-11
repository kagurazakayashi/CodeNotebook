<?php
$l = 100;
for ($i = 0; $i <= $l; $i++) {
    $s = str_repeat('>', $i);
    $e = str_repeat('=', $l - $i);
    $a = $s . $e . ']';
    printf("Loading: %d%%[%s\r", $i, $a );
    usleep(1000 * 100);
}
echo "\n", "Done.\n";