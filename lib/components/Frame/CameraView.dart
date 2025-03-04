import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/FriendSectionPage/FriendImageListPage.dart';
import 'package:locket_mockup/components/Button/WindowButton.dart';

class CameraView extends StatefulWidget {
  final CameraController controller;
  final Future<void> initializeControllerFuture;
  final Function(String) onPictureTaken;

  CameraView({
    required this.controller,
    required this.initializeControllerFuture,
    required this.onPictureTaken,
  });

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
        ),
        Stack(
          children: [
            FutureBuilder<void>(
              future: widget.initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                    width: 368,
                    height: 368,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FittedBox(
                        fit: BoxFit.cover, // ครอบให้เต็มพื้นที่
                        child: SizedBox(
                          width: widget.controller.value.previewSize?.height ??
                              368,
                          height:
                              widget.controller.value.previewSize?.width ?? 368,
                          child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..scale(-1.0, 1.0),
                              child: CameraPreview(widget.controller)),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            WindowButton() , 
              GestureDetector(
                onTap: () async {
                  await widget.initializeControllerFuture;
                  final image = await widget.controller.takePicture();
                  widget.onPictureTaken(image.path);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.favorite,
                      size: 60,
                      color: Color(0xFFF281C1),
                    ),
                  ],
                ),
              ),
              Icon(Icons.restart_alt_rounded, size: 40, color: Colors.white),
            ],
          ),
        ),
        Column(
          children: [
            Center(
              child: Container(
                width: 100,
                height: 50,
                child: Row(
                  children: [
                    Icon(Icons.image, size: 30, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      "History",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down, size: 30, color: Colors.white),
          ],
        )
      ],
    );
  }
}
