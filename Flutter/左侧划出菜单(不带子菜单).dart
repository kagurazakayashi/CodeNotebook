import 'package:<项目名>/左侧划出菜单数据.dart';


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                    ),
                  ),
                ),
              ),
            ],
            margin: EdgeInsets.zero,
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
                      Column(
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
