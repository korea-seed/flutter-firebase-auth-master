import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:get/get.dart';
import 'grouplist.dart';
import 'count_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Coporation World',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: SFWdemoState(title: 'Co'),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SFWdemoState(title: 'Co')),
        GetPage(name: '/second', page: () => GroupListPage()),
      ],
    );
  }
}
/*
class _SFWdemoState extends StatefulWidget{
  _SFWdemoState({Key ? key, required title}) : super(key: key);
  @override
  SFWdemoState createState() => SFWdemoState();
}
*/

class ImsiFun {
  var _visible = 0.0.obs;

  double getVible() {
    return _visible.value;
  }

  void setVible(val) {
    _visible.value = val;
  }

  void Fresh() {
    print('오냐');
    _visible.refresh();
  }
}

class SFWdemoState extends StatelessWidget {
  SFWdemoState({Key? key, required title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Singleton();

    print('sfwdemo build');

    var visible = 0.0.obs;

    var itga = controller.count;
    print('main controller.count = $itga');

    return Scaffold(
      appBar: AppBar(
        title: Text("Coporation World"),
      ),
      body: Column(
        children: [
          // Obx() 함수 안쪽으로 처리할 이미지 위젯을 넣어서 refresh
          Obx(() {
            return InkWell(
                child: AnimatedOpacity(
                    opacity: visible.value = (visible.value == 0) ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 1000),
                    child: Image.asset("images/a-button.png"),
                    onEnd: () {
                      // 화면전환
                      Get.toNamed('/second', arguments: 100);
                      controller.count++;
                      var imsi = controller.count;
                      var tt = visible.value;
                      print('visible.value = $tt');
                      print('main1 controller.count = $imsi');
                    }),
                onTap: () {
                  controller.count++;
                  var imsi = controller.count;
                  print('ontap = $imsi');
                  visible.refresh();
                }

//              onDoubleTap: () {
//                print(" on Double Tap ");
//              },
                );
          }),
          InkWell(
            child: Image.asset("images/b-button.png"),
            onTap: () {},
            onDoubleTap: () {
              print(" on Double Tap ");
            },
          ),

          Text(
                'count = ${controller.count}',
                style: Theme.of(context).textTheme.headline4,
              ),
        ],
      ),
    );
  }
}
