// import 'dart:nativewrappers/_internal/vm/lib/ffi_patch.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:media_kit/media_kit.dart';

void main() => runApp(const VideoApp());

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.networkUrl(
    //     Uri.parse(
    //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    //     ),
    //   )
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
    _controller = VideoPlayerController.asset("output.mp4")
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  "Event based interacting maps algortihm",
                  style: theme.textTheme.displayMedium!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text("""
The interacting maps approach uses the signals from a event based camera like the Dynamic Vision Sensor (DVS) as its only real input. An event camera, also known as a neuromorphic camera,[1] silicon retina,[2] or dynamic vision sensor,[3] is an imaging sensor that responds to local changes in brightness. Event cameras do not capture images using a shutter as conventional (frame) cameras do. Instead, each pixel inside an event camera operates independently and asynchronously, reporting changes in brightness as they occur, and staying silent otherwise. [FOOTNOTE WIKIPEDIA: EVENT-CAMERAS] Since an event camera responds to local temporal changes in image intensity its events can be interpreted as a temporal derivative V. Events are accumulated for visualization purposes over a time frame of 0.005 seconds to form a frame similar to a regular camera. These frames are shown in the top left corner of the following video. Green represents a positive value, red a negative one. Beside the temporal derivative, intrinsic camera parameters like optical center and focal length are used to construct a calibration matrix C. This calibration matrix C maps pixel coordinates to spatial coordinates. V and C are used to reconstruct the image intensity I, the spatial Gradient G and the optical flow F. These quantities are also accumulated for visualization and shown in the top right corner, bottom left corner and bottom right corner.
The image intensity is portrayed as a gray scale image. G and F are vector fields in the pixel plane. Each direction of the vectorfield is represented by a color. This mapping is visualised by the annulus in the center. The intensity of the color represents the magnitude of the vectors. They are not comparable between G and F. The approach assumes that the observed scene is static and the camera is fixed in space but can rotate. The rotational velocity R is also estimated and used for the estimation of F, but not shown in the video.
""", textAlign: TextAlign.justify),
              ),
              Center(
                child:
                    _controller.value.isInitialized
                        ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                        : Container(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
