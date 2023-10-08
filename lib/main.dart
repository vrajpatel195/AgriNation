import 'package:agri/firebase_options.dart';
import 'package:agri/screens/home_screen.dart';
import 'package:agri/screens/welcome_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

bool? isLogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //FirebaseNativeSplace
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DetectionScreen(),
    );
  }
}

class DetectionScreen extends StatefulWidget {
  @override
  _DetectionScreenState createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  List<dynamic>? _recognitions;
  bool _modelLoaded = false;
  var v = "";

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    String modelPath = 'assets/model1.tflite'; // Replace with your model path
    await Tflite.loadModel(
      model: modelPath,
    );
    setState(() {
      _modelLoaded = true;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  Future<void> _detectImage() async {
    XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFile == null)
      return;
    else {
      exect(imageFile);
    }
  }

  void exect(XFile image) async {
    try {
      var recognitions = await Tflite.detectObjectOnImage(
        path: image.path,
        model: 'SSDMobileNet', // Replace with your model name
        imageMean: 127.5,
        imageStd: 127.5,
      );

      setState(() {
        _recognitions = recognitions;
      });
    } catch (e) {
      print('Error running TensorFlow Lite operation: $e');
      // Handle the error gracefully, e.g., show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Model Detection'),
      ),
      body: Center(
        child: Column(
          children: [
            if (_modelLoaded)
              ElevatedButton(
                onPressed: _detectImage,
                child: Text('Detect Image'),
              )
            else
              CircularProgressIndicator(),
            if (_recognitions != null)
              Text(v)
            else
              Text('No image detected yet'),
          ],
        ),
      ),
    );
  }
}
