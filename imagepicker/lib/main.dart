import 'dart:io';
import 'dart:ui';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
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

  bool flag = false;

////////////////////////////////////
  File? _imageFile;
  String _status = '';
  bool _imgLoading = false;
  ImagePicker? _imagePicker;

  @override
  void initState() {
    super.initState();
    image = Image.asset('images/dummy.png');

    pallete = image!.image;
/////////////////////////////////////
    _status = '';
    _imgLoading = false;
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
      ),
      body:
/*
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _imgLoading ? CircularProgressIndicator() :
            null == _imageFile
                ? Container()
                : Expanded(
              child: Image.file(
                File(_imageFile!.path),
                filterQuality: FilterQuality.high,
              ),
            ),
            SizedBox(height: 20),
            Text(_status),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),

*/
          Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ImageDisPlay(),
            image!,
            Stack(
              children: <Widget>[
                Image.asset('images/dummy.png'),
                Container(width: 120, height: 121, color: flag ? paletteGenerator!.lightMutedColor!.color.withOpacity(0.8) : Colors.black.withOpacity(0.5)),
              ],
            ),
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
              onPressed: _loadImage,//getImageFromGallery,
              tooltip: 'Pick Image',
              child: const Icon(Icons.wallpaper),
            ),
            TextButton(
              onPressed: () {
                GetPixel();
//              _select();
              },
              child: const Text('임시로'),
            ),
          ],
        ),
      ),
    );
  }

////////////////////////////////////////
  _select() {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      color: Colors.black12,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _button('Camera', ImageSource.camera),
          _button('gallery', ImageSource.gallery),
        ],
      ),
    );
  }

  _button(String text, ImageSource imageSource) {
    return FlatButton(
      child: Text(text),
      onPressed: () async {
        setState(() {
          _imgLoading = true;
          _imageFile = null;
        });
        File? file = null;//await _loadImage();
        setState(() {
          _imageFile = file as File?;
          _imgLoading = false;
          _status = 'Error';
        });
        return;
        setState(() {
          _imageFile = null;
          _imgLoading = false;
          _status = 'Error';
        });
      },
    );
  }

  Future<File?> _loadImage() async {
//    PickedFile? file = await _imagePicker?.getImage(source: imageSource);

    final ImagePicker _picker = ImagePicker();
    final image1 = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 160, maxHeight: 160);

    File? mFile;
    if (null != image1) {
      Directory directory = await getTemporaryDirectory();
//      Map map = Map();
//      map['path'] = image.path;
//      map['directory'] = directory;
//      mFile = await compute(_saveImageToDisk, map);

      File tempFile = File(image1.path!);
      img.Image? image = img.decodeImage(tempFile.readAsBytesSync());
      img.Image mImage = img.copyResize(image!, width: 140, height: 140);
      String imgType = image1.path!.split('.').last;
      String mPath = '${directory.path.toString()}/image_${DateTime.now()}.$imgType';
      File dFile = File(mPath);
      if (imgType == 'jpg' || imgType == 'jpeg') {
        dFile.writeAsBytesSync(img.encodeJpg(mImage));
      } else {
        dFile.writeAsBytesSync(img.encodePng(mImage));
      }
    }
    return mFile;
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
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      pallete!,
      size: Size(120, 120),
      region: const Rect.fromLTWH(0, 0, 2, 2),
      maximumColorCount: 4,
    );

    if (kDebugMode) {
      print(paletteGenerator!.colors.length);
    }
    if (kDebugMode) {
      print(paletteGenerator!);
    }

    setState(() {
      flag = true;
    });
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
      print('Value of int: $_bytes');
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

                  Directory directory = getTemporaryDirectory() as Directory;

                  String temp = _image!.path;
                  var a = temp.length;
                  temp.replaceRange(a - 6, a - 5, 'tt');
                  print(temp);
                  File(temp).writeAsStringSync;




                  File tempFile = File(_image!.path);
                  img.Image? image = img.decodeImage(tempFile.readAsBytesSync());
                  img.Image mImage = img.copyResize(image!, width: 512);
                  String imgType = _image!.path.split('.').last;
                  String mPath = '${directory.path.toString()}/image_${DateTime.now()}.$imgType';
                  File dFile = File(mPath);
                  if (imgType == 'jpg' || imgType == 'jpeg') {
                    dFile.writeAsBytesSync(img.encodeJpg(mImage));
                  } else {
                    dFile.writeAsBytesSync(img.encodePng(mImage));
                  }
//                  return dFile;

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

  Future<File?> _saveImageToDisk(Map map) async {
    try {
      String path = map['path'];
      Directory directory = map['directory'];
      File tempFile = File(path);
      img.Image? image = img.decodeImage(tempFile.readAsBytesSync());
      img.Image mImage = img.copyResize(image!, width: 512);
      String imgType = path.split('.').last;
      String mPath = '${directory.path.toString()}/image_${DateTime.now()}.$imgType';
      File dFile = File(mPath);
      if (imgType == 'jpg' || imgType == 'jpeg') {
        dFile.writeAsBytesSync(img.encodeJpg(mImage));
      } else {
        dFile.writeAsBytesSync(img.encodePng(mImage));
      }
      return dFile;
    } catch (e) {
      return null;
    }
  }
}
