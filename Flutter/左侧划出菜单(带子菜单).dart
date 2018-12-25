import 'package:<项目名>/左侧划出菜单数据.dart';


final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static final Animatable<Offset> _drawerDetailsTween = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  ).chain(CurveTween(
    curve: Curves.fastOutSlowIn,
  ));

  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;
  bool _showDrawerContents = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = _controller.drive(_drawerDetailsTween);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _showNotImplementedMessage() {
    Navigator.pop(context); // Dismiss the drawer.
  }

  _showmessage(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _onOtherAccountsTap(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Account switching not implemented.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

_drawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text('Trevor Widget'),
            accountEmail: const Text('trevor.widget@example.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage(
                _kAsset0,
                // package: _kGalleryAssetsPackage,
              ),
            ),
            otherAccountsPictures: <Widget>[
              GestureDetector(
                onTap: () {
                  _onOtherAccountsTap(context);
                },
                child: Semantics(
                  label: 'Switch to Account B',
                  child: const CircleAvatar(
                    backgroundImage: AssetImage(
                      _kAsset1,
                      // package: _kGalleryAssetsPackage,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _onOtherAccountsTap(context);
                },
                child: Semantics(
                  label: 'Switch to Account C',
                  child: const CircleAvatar(
                    backgroundImage: AssetImage(
                      _kAsset2,
                      // package: _kGalleryAssetsPackage,
                    ),
                  ),
                ),
              ),
            ],
            margin: EdgeInsets.zero,
            onDetailsPressed: () {
              _showDrawerContents = !_showDrawerContents;
              if (_showDrawerContents)
                _controller.reverse();
              else
                _controller.forward();
            },
          ),
          MediaQuery.removePadding(
            context: context,
            // DrawerHeader consumes top MediaQuery padding.
            removeTop: true,
            child: Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 8.0),
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      // The initial contents of the drawer.
                      FadeTransition(
                        opacity: _drawerContentsOpacity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: DrawerContents.map<Widget>((String id) {
                            return ListTile(
                              leading: CircleAvatar(child: Text(id)),
                              title: Text('Drawer item $id'),
                              onTap: () {
                                _showNotImplementedMessage();
                                _showmessage('Drawer item $id');
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      // The drawer's "details" view.
                      SlideTransition(
                        position: _drawerDetailsPosition,
                        child: FadeTransition(
                          opacity: ReverseAnimation(_drawerContentsOpacity),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children:DrawerSetting.map<Widget>((List settings) {
                              return ListTile(
                                leading: settings[0],
                                title: Text(settings[1]),
                                onTap: () {
                                  _showNotImplementedMessage();
                                  _showmessage(settings[1]);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
