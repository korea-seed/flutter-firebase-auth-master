import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'count_controller.dart';

class GroupListPage extends StatelessWidget {
  @override
  static const List<String> _data = [
    '직원 1',
    '직원 2',
    '직원 3',
    '직원 4',
    '직원 5',
    '직원 6',
    '직원 7',
  ];

  static const List<int> _human = [
    0,
    1,
    0,
    0,
    1,
    1,
    0,
  ];

  final List _isLol = [];




  Widget build(BuildContext context) {
    var controller1 = Singleton();

    return Scaffold(
        appBar: AppBar(
          title: Text('GroupListPage'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.navigate_before),
              tooltip: 'before page',
              onPressed: () {
                //  이전화면으로 돌아간다
                int value = Get.arguments;
                print(value);
//                Get.back(closeOverlays: true);
                //  Get.back으로 하게되면 build를 안하게 되어 이전화면의 Obx내용이 업뎃이 안된다
                Get.toNamed('/', arguments: 10);
                controller1.count--;
              },
            ),
          ],
          leading: Builder(
            builder: (context) {
              return Container();
            },
          ),
          leadingWidth: 0,
        ),
        body: ListView.separated(
            scrollDirection: Axis.vertical,
            //vertical : 수직으로 나열 / horizontal : 수평으로 나열
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  color: Colors.black,
                ),
            //separatorBuilder : item과 item 사이에 그려질 위젯 (개수는 itemCount -1 이 된다)
            itemCount: _data.length,
            //리스트의 개수
            itemBuilder: (BuildContext context, int i) {

                _isLol.add(true);
                print('[$i] = ${_isLol[i]}\n');

              //리스트의 반목문 항목 형성
              return ListTile(
                leading: (_human[i] == 0) ? Icon(Icons.man) : Icon(Icons.woman),
//                leading: Icon(Icons.man),
                title: Text(_data[i]),

              );
            }));
  }
}
