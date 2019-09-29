BackdropFilter(
  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
  child: DecoratedBox(
    decoration: BoxDecoration(color: Colors.yellow),
    child: Text("val"),
  ),
),
