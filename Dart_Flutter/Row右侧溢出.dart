@override
  Widget build(BuildContext context) {
    DataPost post = widget.data;
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: Row(
        children: [
          // 加 Expanded
          Expanded(child: Text(post.content)),
        ],
      ),
    );
  }