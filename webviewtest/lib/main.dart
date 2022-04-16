import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'naver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _MyHomePageState(),
    );
  }
}
/*
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
*/
class _MyHomePageState extends StatelessWidget {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(url: Uri.parse("https://daum.net/")),
            initialOptions: options,
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
          ),
        ),
      ),
/*
      onWillPop: () {
        var future = webViewController!.canGoBack();
        future.then((canGoBack) {
          if (canGoBack) {
            webViewController!.goBack();
          } else {
            return showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("앱을 종료하시겠습니까?"),
                      actions: <Widget>[
                        TextButton(
                          child: Text("아니요"),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        TextButton(
                          child: Text("예"),
                          onPressed: () => SystemNavigator.pop(),
                        )
                      ],
                    ));
          }
        });
        return Future.value(false);
      },
 */
     );
  }
}
