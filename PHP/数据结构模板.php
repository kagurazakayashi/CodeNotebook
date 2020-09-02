<?php
class st_posts {
    public $keys,$id,$post,$date;
    public function __construct($arr) {
        $this->keys = array_keys($arr);
        foreach ($this->keys as $key) $this->{$key} = $arr[$key] ?? null;
    }
    public function __destruct() {
        foreach ($this->keys as $key) unset($this->{$key});
        unset($this->keys);
    }
}
?>