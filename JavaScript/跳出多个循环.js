aaa:
for (var i = 0; i < 100; i++) {
    bbb:
    for (var j = 0; j < 200; j++) {
        console.log(i, j);
        if (j == 5) {
            break aaa; //直接跳出外层循环bbb
        }
    }
}