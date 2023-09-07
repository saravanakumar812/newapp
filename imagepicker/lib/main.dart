import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? PickedImage;
  Future pickImageFromGallery() async {
    try {
      final image1 = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image1 == null) return;

      final imageTemp = File(image1.path);
      setState(() {
        this.PickedImage = imageTemp;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image1 = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image1 == null) return;

      final imageTemp = File(image1.path);
      setState(() {
        this.PickedImage = imageTemp;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Image Picker'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      pickImageFromGallery();
                    },
                    icon: Icon(Icons.image)),
                IconButton(
                    onPressed: () {
                      pickImageFromCamera();
                    },
                    icon: Icon(Icons.camera)),
                Container(
                  child: PickedImage != null
                      ? Image.file(PickedImage!)
                      : Text('No Image'),
                )
              ],
            ),
          ),
        ));
  }
}
