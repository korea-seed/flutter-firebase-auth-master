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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
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
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike))
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
