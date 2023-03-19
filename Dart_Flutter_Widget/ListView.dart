class ListViews {
  /// 简易列表
  /// 用ListView的children属性来实现一个滚动列表是最简单的一种实现方式
  Widget list() {
    return ListView(
      shrinkWrap: false,
      //沿竖直方向上布局
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(30),
      //每个子组件的高度
      itemExtent: 30,
      children: const <Widget>[Text('1'), Text('2'), Text('3'), Text('4'), Text('5'), ],
    );
  }
  /*
  在此段代码中shrinkWrap属性为false时，代表ListView会在布局方向上尽可能多的占用空间。当shrinkWrap值为true时，则会根据子Widget的大小来确定ListView的大小，shrinkWrap的值默认为false。另外当shrinkWrap为true时，下拉列表不会有任何反应。而为false时，在iOS系统下则会有弹簧效果。
  scrollDirection属性则决定了ListView子组件的布局方向，即ListView的滚动方向。Axis.vertical为竖直方向。Axis.horizontal为水平方向。
  itemExtent属性为设置每个子组件的高度。如果此属性为null，则子组件则默认为自身高度。与UITableView一样，设置子组件的高度，会让ListView更高效。
  */


  /// 滚动列表 ListView.builder
  /// 除了children之外，ListView还有另外一种构造方法ListView.builder，我们用一段代码来看一下如何用ListView.builder来实现一个滚动列表
  Widget list2() {
    return ListView.builder(
      padding: const EdgeInsets.all(30),
      //子Widget数量
      itemCount: 30,
      //子Widget高度
      itemExtent: 50,
      itemBuilder: (BuildContext context, int index) {
        return Text("$index");
      },
    );
  }
  /*
  用ListView.builder构建ListView时需要设置itemCount属性来指定子Widget的数量。
  注：用上面children的方式来构建时，不能指定itemCount，否则会编译失败。
  */


  /// 带分隔线列表 ListView.separated
  /// ListView.separated与ListView.builder不同的是，它可以设置ListView各个子Widget之间的分割线。
  Widget list3() {
    return ListView.separated(
      padding: const EdgeInsets.all(30),
      itemCount: 30,
      itemBuilder: (BuildContext context, int index) {
        //子Widget
        return SizedBox(
          height: 50,
          child: ListTile(title: Text("$index")),
        );
      },
      //设置分割线，颜色为黑色，高度为1
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: Colors.black,
          height: 1,
        );
      },
    );
  }



  /// 下拉刷新
  /// 在Flutter中下拉刷新需要用RefreshIndicator把ListView包装一层，然后实现onRefresh方法。
  var itemCount = 30;
  Widget refresh() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.all(30),
        itemCount: itemCount + 1,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 50,
            child: ListTile(title: Text("$index")),
          );
        },
        //设置分割线，颜色为黑色，高度为1
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.black,
            height: 1,
          );
        },
      ),
    );
  }
  Future _onRefresh() {
    //可根据业务做刷新操作，必须返回一个Future，此处仅做2秒延迟
    return Future.delayed(const Duration(seconds: 2), () {
      print("刷新完成");
      setState(() {
        itemCount = 30;
      });
    });
  }



  /// 上拉加载更多
  /// 上拉加载系统并没有给我们提供好组件，但是我们可以根据ListView的controller属性进行监听，等ListView滚动至最后一个item开始上拉加载操作。
  //正在加载更多标记
  var isLoadingMore = false;
  var itemCount = 30;
  ScrollController scrollController = ScrollController();
  void initState() {
    super.initState();
    scrollController.addListener(() {
      //监听滑动至最后
      if (isLoadingMore == false && scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        setState(() {
          isLoadingMore = true;
          _loadMore();
        });
      }
    });
  }
  Future _loadMore() {
    //可以此处添加加载更多的接口请求，实际开发中可根据实际情况加载数据
    return Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoadingMore = false;
      });
    });
  }
  Widget loadingMore() {
    Widget _getLoadMoreWidget() {
      if (isLoadingMore == true) {
        return Container(
          alignment: Alignment.center,
          child: const SizedBox(width: 25.0, height: 25.0, child: CircularProgressIndicator(strokeWidth: 2.0)),
        );
      } else {
        return Container(
          alignment: Alignment.center,
          child: const Text("上拉加载"),
        );
      }
    }
    return RefreshIndicator(
      onRefresh: () {
        print("onRefresh");
        return Future.delayed(const Duration(seconds: 2), () {
          print("onRefresh end");
        });
      },
      child: ListView.separated(
        controller: scrollController,
        padding: const EdgeInsets.all(30),
        itemCount: itemCount + 1,
        itemBuilder: (BuildContext context, int index) {
          // //子Widget
          if (index == itemCount) {
            return _getLoadMoreWidget();
          }
          return Container(
            height: 50,
            child: ListTile(title: Text("$index")),
          );
        },
        //设置分割线，颜色为黑色，高度为1
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.black,
            height: 1,
          );
        },
      ),
    );
  }
}


// https://mp.weixin.qq.com/s?__biz=MzkwMDIxNDA3NA==&mid=2247483856&idx=1&sn=8f4bac68abad5906364217c1070663c2&chksm=c0463d85f731b493dcdcf9693a501ca280ec0035a34c4752c955531e013f6c23207bc03f3273&token=1045970176&lang=zh_CN#rd
