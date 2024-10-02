import 'dart:io';
import 'dart:typed_data';
import 'package:blnk_flutter/blocs/info/info_bloc.dart';
import 'package:blnk_flutter/blocs/info/info_events.dart';
import 'package:blnk_flutter/blocs/info/info_states.dart';
import 'package:blnk_flutter/methods/navigations.dart';
import 'package:blnk_flutter/screens/create_account.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:image/image.dart' as img;

class IdCapture extends StatefulWidget {

  final String subtitle;
  final String capturedSide;

  IdCapture({
    super.key,
    required this.subtitle,
    required this.capturedSide,
  });

  @override
  _IdCaptureState createState() => _IdCaptureState();
}

class _IdCaptureState extends State<IdCapture> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  String? _capturedImagePath;
  bool _isCaptured = false;
  String? _croppedImagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {

    if (_controller != null) {
      await _controller?.dispose();
    }

    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    print("Camera orientation: ${firstCamera.sensorOrientation}");

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller?.initialize();

    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<InfoBloc, InfoState>(
          listener: (context, state) {
            if(state is InfoIdFrontSubmitted) {
              _controller?.dispose();
              navigateAndReplace(context, IdCapture(subtitle: "Back", capturedSide: "Back",));
            }
            if(state is InfoIdBackSubmitted) {
              _controller?.dispose();
              navigateAndReplace(context, const CreateAccount(initialPage: 2));
            }
          },
          child: BlocBuilder<InfoBloc, InfoState>(
            builder: (context, state) {
              return FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Stack(
                      children: [
                        if (!_isCaptured)
                          Positioned.fill(child: CameraPreview(_controller!)),
                        if (!_isCaptured)
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 42.0),
                                const Text(
                                  "Capture ID",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.0),
                                ),
                                Text(
                                  widget.subtitle,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: (MediaQuery.of(context).size.width) * 0.9,
                                  height: (((MediaQuery.of(context).size.width) * 0.9) * 5.5) / 8.5,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green, width: 2),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 21.0),
                                  child: FloatingActionButton(
                                    backgroundColor: Colors.blue,
                                    onPressed: () async {
                                      if (!_isCaptured) {
                                        await _captureAndCropImage(state);
                                      }
                                    },
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _captureAndCropImage(InfoState state) async {
    try {
      await _initializeControllerFuture;

      final image = await _controller?.takePicture();
      if (image == null) return;

      setState(() {
        _capturedImagePath = image.path;
        _isCaptured = true;
      });

      // Load the image as bytes (Uint8List)
      final bytes = await File(_capturedImagePath!).readAsBytes();

      // Automatically crop the image
      _croppedImagePath = await _autoCropImage(bytes);
      if (_croppedImagePath != null) {
        print('Cropped image saved at: $_croppedImagePath');
        context.read<InfoBloc>().add(
            state is InfoAddressSubmitted
                ? InfoSubmitIdFront(idFrontPath: _croppedImagePath!)
                : InfoSubmitIdBack(idBackPath: _croppedImagePath!)
        );
      }

    } catch (e) {
      print(e);
    }
  }

  Future<String?> _autoCropImage(Uint8List imageData) async {
    final originalImage = img.decodeImage(imageData);
    if (originalImage == null) return null;

    // Define the cropping rectangle based on the green rectangle's dimensions
    final width = (originalImage.width * 0.9).toInt(); // 90% of width
    final height = ((originalImage.width * 5.5) / 8.5).toInt(); // Aspect ratio 5.5:8.5
    final x = (originalImage.width - width) ~/ 2; // Center x
    final y = (originalImage.height - height) ~/ 2; // Center y

    final croppedImage = img.copyCrop(originalImage, x: x, y: y, width: width, height: height);

    // Convert the cropped image back to U_int8List
    final Uint8List croppedBytes = Uint8List.fromList(img.encodePng(croppedImage));

    // Save the cropped image
    final directory = await getApplicationDocumentsDirectory();
    final String filePath = p.join(directory.path, "id_${widget.capturedSide}_cropped.png");
    final File file = File(filePath);
    await file.writeAsBytes(croppedBytes);

    return filePath;
  }
}
