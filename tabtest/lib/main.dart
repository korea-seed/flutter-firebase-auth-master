import 'package:animated_drawer/views/animated_drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePageState(),
    );
  }
}

class MyHomePageState extends StatelessWidget {
//  late TabController _tabController;
  @override

  Widget build(BuildContext context) {
    return DefaultTabController(

      initialIndex: 0,
      length: 9,
      child: Scaffold(
        appBar: AppBar(
//        title: Text('Main'),
//        centerTitle: true,
//        elevation: 0.0,

          leading: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset("images/logo.jpg"),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
              Tab(text: '메인'),
              Tab(text: '나의스타픽'),
              Tab(text: '차트'),
              Tab(text: '스타들'),
              Tab(text: '투표'),
              Tab(text: '이벤트')
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
            Tab(text: '메인'),
            Tab(text: '나의스타픽'),
            Tab(text: '차트'),
            Tab(text: '스타들'),
            Tab(text: '투표'),
            Tab(text: '이벤트')
          ],
        ),
      ),
    );
  }
}

class AniDraw extends StatelessWidget {
  const AniDraw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedDrawer(
        backgroundGradient:
            LinearGradient(colors: [Color(0xFF4c41a3), Color(0xFF1f186f)]),
        menuPageContent: Padding(
          padding: const EdgeInsets.only(top: 100.0, left: 15),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlutterLogo(
                  size: MediaQuery.of(context).size.width / 4,
                ),
                Row(
                  children: [
                    Text(
                      "FLUTTER",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "HOLIC",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.blue[200],
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 40),
                ),
                Text(
                  "Home Screen",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Text(
                  "Screen 2",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
              ],
            ),
          ),
        ),
        homePageContent: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.blue[200],
        ),
        shadowColor: Color(0xFF4c41a3));
  }
}
