import 'dart:io';
import 'dart:ui';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:image/image.dart' as img;

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
      home: MyHomePage(title: 'Image Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  XFile? _image;
  Image? image;
  ImageProvider? pallete;
  PaletteGenerator? paletteGenerator;

  Uint8List? data;
  img.Image? photo;

  @override
  void initState() {
    image = Image.asset('images/dummy.png');
    pallete = image!.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ImageDisPlay(),
            image!,
            FloatingActionButton(
              onPressed: updatePaletteGenerator,
              tooltip: 'PalletteGen',
              child: const Icon(Icons.sports_kabaddi_rounded),
            ),
            FloatingActionButton(
              onPressed: getImageFromCam,
              tooltip: 'Pick Image',
              child: const Icon(Icons.add_a_photo),
            ),
            FloatingActionButton(
              onPressed: getImageFromGallery,
              tooltip: 'Pick Image',
              child: const Icon(Icons.wallpaper),
            ),
            TextButton(
              onPressed: () {
                  GetPixel();
              },
//              tooltip: 'Pick Image',
              child: const Text('임시로'),
            ),
          ],
        ),
      ),
    );
  }

  getImageFromCam() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image == null) return;
      final imageTemporary = XFile(image.path);
      _image = imageTemporary;
    });
  }

  getImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 160, maxHeight: 160);
    setState(() {
      if (image == null) return;
      final imageTemporary = XFile(image.path);
      _image = imageTemporary;
    });
  }

  updatePaletteGenerator() async {
    var _paletteGenerator = await PaletteGenerator.fromImageProvider(
      pallete!,
      size: Size(120, 120),
      region: const Rect.fromLTWH(0, 0, 2, 2),
      maximumColorCount: 4,
    );

    if (kDebugMode) {
      print(_paletteGenerator.colors.length);
    }
    if (kDebugMode) {
      print(_paletteGenerator);
    }

    setState(() {});
  }

  Widget Pallete() {
    return Container();
  }

  int abgrToArgb(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }

  GetPixel() async {
    const coverData = 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg';
    try {
      data = (await NetworkAssetBundle(Uri.parse(coverData)).load(coverData)).buffer.asUint8List();
    } catch (ex) {
      if (kDebugMode) {
        print(ex.toString());
      }
    }

    ByteData data1 = await rootBundle.load('images/dummy.png');
    Uint8List _bytes = Uint8List.view(data1.buffer);

//    img.decodeImage(_bytes);


//    List<int> values = data!.buffer.asUint8List();
    photo = null;
//    photo = img.decodeImage(values);
    photo = img.decodeImage(_bytes);

    double px = 0.0;
    double py = 0.0;

    photo!.setPixel(0, 0, 0xff000000);
    int pixel32 = photo!.getPixelSafe(px.toInt(), py.toInt());


    int hex = abgrToArgb(pixel32);
    if (kDebugMode) {
      print('Value of int: ${hex.toRadixString(16)}');
    }
    return Color(hex);
  }

  Widget ImageDisPlay() {
    if (_image == null) {
      return const Text('없슴');
    } else {
//      final deco = decodeImage(File(_image!.path).readAsBytesSync())!;
//      final thumnail = copyResize(deco, width: 100, height: 100);
//      File('thum.png').writeAsBytesSync(encodePng(thumnail));

//      File(_image!.path).readAsBytesSync()!;
//      File(_image!.path).writeAsStringSync;

      Future<Directory?>? tempDir;
      tempDir = getTemporaryDirectory();
//      String tempPath = tempDir.path;

      return Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
//        child: Image.file(File(_image!.path)),
        child: FutureBuilder<Directory?>(
            future: tempDir,
            builder: (BuildContext context, AsyncSnapshot<Directory?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  if (kDebugMode) {
                    print(snapshot.data!.path);
                  }
                  if (kDebugMode) {
                    print(_image!.path);
                  }

                  String temp = _image!.path;
                  var a = temp.length;
                  temp.replaceRange(a - 6, a - 5, 'tt');
                  print(temp);
                  File(temp).writeAsStringSync;
                  return
//                  Text('path: ${snapshot.data!.path}');
                      Image.file(File(_image!.path), width: 100, height: 100);
                } else {
                  return const Text('path unavailable');
                }
              } else {
//              setState(() {
                return const Text('ing');
//              }
//            );
              }
            }),
      );
    }
  }
}
