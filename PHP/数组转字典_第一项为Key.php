function arrayToDictionary($srcArray) {
    $dic = [];
    foreach ($srcArray as $nowval) {
        $nowkey = array_splice($nowval, 0, 1);
        $dic[$nowkey[0]] = $nowval;
    }
    return $dic;
}
