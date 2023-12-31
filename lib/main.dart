import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: AdminMobilePage(),
    );
  }
}

class AdminMobilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideNavigation(),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(child: PostList())
        ],
      ),
    );
  }
}

class SideNavigation extends StatefulWidget {
  @override
  _SideNavigationState createState() => _SideNavigationState();
}

class _SideNavigationState extends State<SideNavigation> {
  int selectedIndex = 0;
  //現在選択されているナビゲーションアイテムのインデックスを保持する。デフォルト値として0が設定されていて、最初は最初のアイテムが選択された状態

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      //サイドバーで使用するためのMaterial Designウィジェット
      selectedIndex: selectedIndex, //NavigationRailに現在選択されているアイテムのインデックスを伝える
      onDestinationSelected: (index) {
        setState(() {
          selectedIndex = index;
        });
      }, //ユーザーが新しいアイテムを選択したときに呼び出されるコールバック関数
      //選択されたアイテムのインデックスを受け取り、setStateを使用してselectedIndexを更新する
      destinations: [
        //NavigationRailのアイテムをリスト形式で定義
        NavigationRailDestination(
          icon: Icon(Icons.thumbs_up_down),
          label: Text('ThumbsUpDown'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.people),
          label: Text('People'),
        ),
        NavigationRailDestination(icon: Icon(Icons.face), label: Text('Face')),
        NavigationRailDestination(
            icon: Icon(Icons.bookmark), label: Text('Bookmark')),
      ],
    );
  }
}

class _PostHeader extends StatelessWidget {
  //プライベートな要素には_(アンダースコア）をつける
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: ListTile(
              leading: ClipOval(
                  // 先頭に表示するウィジェット：　角張った部分を円形や楕円形に切り抜く
                  child: Container(
                color: Colors.grey[300],
                width: 48,
                height: 48,
                child: Icon(
                  Icons.storage,
                  color: Colors.grey[800],
                ),
              )),
              title: Text('Posts'),
              subtitle: Text('20 Posts'),
            )),
        Expanded(
            flex: 1,
            child: ListTile(
              leading: ClipOval(
                  child: Container(
                color: Colors.grey[300],
                width: 48,
                height: 48,
                child: Icon(
                  Icons.style,
                  color: Colors.grey[800],
                ),
              )),
              title: Text('All Types'),
              subtitle: Text(''),
            ))
      ],
    );
  }
}

class _Post extends StatelessWidget {
  final String name;
  final String message;
  final String textReason;
  final Color colorPrimary;
  final Color colorPositive;
  final String textPositive;
  final Color colorNegative;
  final String textNegative;

  const _Post({
    Key? key, //Null Safetyエラー出た　Dart２.12以前の書き方になっていた
    required this.name,
    required this.message,
    required this.textReason,
    required this.colorPrimary,
    required this.colorPositive,
    required this.textPositive,
    required this.colorNegative,
    required this.textNegative,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
          elevation: 8, //影の濃さ
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              ListTile(
                leading: ClipOval(
                    child: Container(
                  color: colorPrimary,
                  width: 48, //丸のサイズ
                  height: 48,
                  child: Center(
                      child: Text(
                    name.substring(0, 1),
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )),
                )),
                title: Text(name),
                subtitle: Text('2 min ago'),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 50),
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        border: Border.all(color: colorPrimary, width: 4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(width: 8),
                    Flexible(child: Text(message))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: colorPrimary, width: 2),
                      )),
                      child: Text(
                        textReason,
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                        child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: colorNegative,
                      ),
                      onPressed: () {},
                      child: Text(textNegative),
                    )),
                    SizedBox(width: 8),
                    Expanded(
                        child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: colorPositive,
                        backgroundColor: colorPositive.withOpacity(0.2),
                      ),
                      onPressed: () {},
                      child: Text(textPositive),
                    )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class _PostGreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Post(
      name: 'Pean',
      message: 'Weak reason. No action required.',
      textReason: 'Report Details',
      colorPrimary: Colors.greenAccent,
      colorPositive: Colors.greenAccent,
      textPositive: 'Keep',
      colorNegative: Colors.blueAccent,
      textNegative: 'Archive',
    );
  }
}

class _PostRed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Post(
        name: 'Namaga Tema',
        message: 'Not recomended for publication',
        textReason: 'Pending Reason',
        colorPrimary: Colors.deepOrangeAccent,
        colorPositive: Colors.blueAccent,
        textPositive: 'Publish',
        colorNegative: Colors.deepOrangeAccent,
        textNegative: 'Decline');
  }
}

class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 70),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _PostHeader(),
          Expanded(
              child: ListView(
            children: [
              _PostGreen(),
              _PostRed(),
              _PostGreen(),
              _PostRed(),
              _PostGreen(),
              _PostRed(),
            ],
          ))
        ],
      ),
    );
  }
}
