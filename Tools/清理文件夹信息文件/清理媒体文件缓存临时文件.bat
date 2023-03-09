TITLE 清理媒体文件缓存临时文件
FOR %%a IN ( C: D: E: F: G: H: I: J: K: L: M: N: O: P: Q: R: S: T: U: V: W: X: Y: Z: ) DO DEL /f/s/q/a "%%a\Thumbs.db" "%%a\.DS_Store" "%%a\._*"
DEL /f/s/q/a "Thumbs.db" ".DS_Store" "._*"
