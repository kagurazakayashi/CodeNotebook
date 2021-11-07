return Container(
    height: 400,
    width: 400,
    color: Colors.red,
    child: Stack(
    children: [
        Positioned(
        left: 10,
        top: 10,
        width: 60,
        height: 60,
        child: Container(
            color: Colors.black,
        ),
        ),

        Positioned(
        right: 10,
        top: 10,
        width: 60,
        height: 60,
        child: Container(
            color: Colors.blue,
        ),
        ),
        Positioned(
        left: 10,
        bottom: 10,
        width: 40,
        height: 40,
        child: Container(
            color: Colors.yellow,
        ),
        ),
        Positioned(
        bottom: 10,
        right: 10,
        width: 40,
        height: 40,
        child: Container(
            color: Colors.deepPurple,
        ),
        )
    ],
    ),
);

// https://www.jianshu.com/p/71032df2759d