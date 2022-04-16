import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'count.dart';

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
      home: ChangeNotifierProvider<Counter>(
          create: (_) => Counter(),
          child: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  var listcount;

  @override
  Widget build(BuildContext context) {
    listcount = context.watch<Counter>().getCount();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
/*
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(8),
              crossAxisCount: 8, // 하나의 Row 에 몇개의 아이템을 넣을것인가
              crossAxisSpacing: 10, // 세로 줄 너비 조절
              mainAxisSpacing: 30, // 가로 줄 너비 조절
              children: List.generate(32, (index) {
                return Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.all(8),
                  child: Center(child: Text('A')),
                );
              }),
            ),
          ),
        ],
      ),
*/
      body: BodyPart(context),


      drawer: ChangeNotifierProvider(
        create: (BuildContext context) => Counter(),
        child: Drawer(
          child: Column(
            children: [
              //  이름
              Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('장병근'),
                    Text('톱니'),
                  ],
                ),
              ),
              //  레벨
              Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('2'),
                    Text('0'),
                    Text('3422'),
                  ],
                ),
              ),

              // 스타픽포함하는 큰 사각형
              Expanded(
//              child: Container(
//              width: MediaQuery.of(context).size.width / 2,
//              height: MediaQuery.of(context).size.height,
//                color: Colors.orange,

                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: <Widget>[

                StarListView(listcount),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // 리스트뷰
                        Container(
                          color: Colors.yellow,
//                        height: 500,
                          child: Text('리스트뷰'),
                        ),
                        // 나의 스타설정 안쪽
                        Container(
                          color: Colors.red,
                          child: InkWell(
                            child: Text('나의 스타설정'),
                          ),
                        ),

                        Container(
                          color: Colors.blue,
                          child: InkWell(
                            child: Text('친구초대'),
                          ),
                        ),

                        Container(
                          color: Colors.white,
                          child: InkWell(
                            child: Text('피드백보내기'),
                          ),
                        ),

                        Container(
                          color: Colors.green,
                          child: InkWell(
                            child: Text('언어변경'),
                          ),
                        ),

                        Container(
                          color: Colors.brown,
                          child: InkWell(
                            child: Text('도움말'),
                          ),
                        ),

                        Container(
                          color: Colors.deepPurple,
                          child: InkWell(
                            child: Text('개인보호정책'),
                          ),
                        ),

                        Container(
                          color: Colors.grey,
                          child: InkWell(
                            child: Text('서비스약관'),
                          ),
                        ),

                        Container(
                          color: Colors.white10,
//                        height: 300,
                          child: Text(
                              'KPOP STARPIC ${context.watch<Counter>().getCount()}'),
                        ),
                      ],
                    ),
                  ],
                ),
//              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget StarListView(int count) {
    return ListView.builder(
      shrinkWrap: true,
        itemCount: count,
        itemBuilder: (context, index) {
          return Container(
            child: Row(
              children: [
                Image.asset('images/ic_launcher.png'),
                count == 0 ? Text('로그인') : Text('테슬라'),
              ],
            ),
          );
        });
  }

  Widget BodyPart(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
            child: Text('Count+'),
            onPressed: () {
              context.read<Counter>().increamentCount();
            },
          ),

          TextButton(
            child: Text('Count-'),
            onPressed: () {
              context.read<Counter>().unincreamentCount();
            },
          ),
        ],
      ),
    );
  }
}
