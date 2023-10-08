import 'dart:io';

import 'package:agri/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class result extends StatefulWidget {
  final XFile image;
  const result({Key? key, required this.image}) : super(key: key);

  @override
  State<result> createState() => _resultState();
}

class _resultState extends State<result> {
  List<dynamic>? _recognitions;
  bool loaiding = true;
  File? image1;
  List? _output;

  var v = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detectimage(widget.image);
    loadmodel().then((value) {
      setState(() {});
    });
  }

  loadmodel() async {
    await Tflite.loadModel(
      model: "assets/model1.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future detectimage(XFile image) async {
    var recognitions = await Tflite.detectObjectOnImage(
      path: image.path,
      model: 'model1.tflite', // Replace with your model name
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _output = recognitions;
      loaiding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Result',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xFF4A9967), Color(0xFF206D3D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFF62DACA), Color(0xFF2FBF71)]),
          borderRadius: BorderRadius.circular(18),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 460,
              width: 350,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 600,
                      width: 350,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 96, 157, 119),
                          Color(0xFF206D3D)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )),
                    ),
                  ),

                  //use the positioned widget to place

                  Positioned(
                    top: 10,
                    right: 100,
                    child: Container(
                      height: 150,
                      width: 150,
                      child: widget.image == null
                          ? Text("no image selected")
                          : Image.file(
                              File(widget.image.path),
                            ),
                    ),
                  ),

                  Positioned(
                    top: 170,
                    left: 20,
                    child: CircularProgressIndicator(),
                  ),

                  // const Positioned(
                  //   top: 100,
                  //   left: 40,
                  //   child: Text(
                  //     "Assitant Professor",
                  //     style: TextStyle(
                  //         color: Color.fromARGB(255, 255, 255, 255),
                  //         fontSize: 16.0,
                  //         fontWeight: FontWeight.w500),
                  //   ),
                  // ),

                  const Positioned(
                    top: 200,
                    left: 20,
                    child: Text(
                      "1) Balanced Fertilizer: Using a balanced fertilizer \nwith a ratio of essential nutrients (such as \nnitrogen,phosphorus,and potassium) can help\nimprove the overall health and vigor of your plants.\n\n2) Organic Matter: Incorporating organic matter,\nsuch as compost  , into your soil can improve its\nstructure and nutrient content. Healthy soil often\nleads to healthier plants that are more resistant to \ndiseases.",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 100,
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),

                  // Positioned(
                  //   bottom: 55,
                  //   left: 20,
                  //   child: SizedBox(
                  //     width: 300,
                  //     child:
                  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: const [
                  //           Icon(Icons.phone),
                  //           Text(
                  //             "+91 9048904851",
                  //             style: TextStyle(
                  //                 color: Color.fromARGB(255, 255, 255, 255),
                  //                 fontSize: 14.0,
                  //                 fontWeight: FontWeight.w500),
                  //           ),
                  //         ],
                  //       ),
                  //       const SizedBox(
                  //         width: 15,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: const [
                  //           Icon(Icons.email),
                  //           Text(
                  //             "+91 9048904851",
                  //             style: TextStyle(
                  //                 color: Color.fromARGB(255, 255, 255, 255),
                  //                 fontSize: 14.0,
                  //                 fontWeight: FontWeight.w500),
                  //           ),
                  //         ],
                  //       )
                  //     ]),
                  //   ),
                  // ),

                  // const Positioned(
                  //   right: 40,
                  //   top: 85,
                  //   child: Center(
                  //     child: Text(
                  //       "View Profile",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
