import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Make sure to add following packages to pubspec.yaml:
// * media_kit
// * media_kit_video
// * media_kit_libs_video
import 'package:media_kit/media_kit.dart'; // Provides [Player], [Media], [Playlist] etc.
import 'package:media_kit_video/media_kit_video.dart'; // Provides [VideoController] & [Video] etc.

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Necessary initialization for package:media_kit.
  MediaKit.ensureInitialized();
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VideoState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 199, 36, 38),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}

class VideoState extends ChangeNotifier {
  List<String> videoNames = ["Shapes", "Poster", "Boxes"];
  List<String> videoFiles = [
    "assets/shapes_rotation_short.mp4",
    "assets/poster_rotation_ultra_short.mp4",
    "assets/boxes_rotation_ultra_short.mp4",
  ];
  List<Icon> videoIcons = [
    Icon(Icons.play_arrow),
    Icon(Icons.play_arrow_outlined),
    Icon(Icons.play_arrow_outlined),
  ];
  var currentIndex = 0;
  late String current = videoNames[currentIndex];
  late String currentVideoFile = videoFiles[currentIndex];

  void selectVideo(int index) {
    videoIcons[currentIndex] = Icon(Icons.play_arrow_outlined);
    currentIndex = index;
    current = videoNames[index];
    currentVideoFile = videoFiles[index];
    videoIcons[index] = Icon(Icons.play_arrow);
    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<VideoState>();
    String videoName = appState.current;
    final theme = Theme.of(context);
    final placeholderColor = theme.primaryColor;

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text("""
The interacting maps approach uses the signals from a event based camera like the Dynamic Vision Sensor (DVS) as its only real input. An event camera, also known as a neuromorphic camera,[1] silicon retina,[2] or dynamic vision sensor,[3] is an imaging sensor that responds to local changes in brightness. Event cameras do not capture images using a shutter as conventional (frame) cameras do. Instead, each pixel inside an event camera operates independently and asynchronously, reporting changes in brightness as they occur, and staying silent otherwise. [FOOTNOTE WIKIPEDIA: EVENT-CAMERAS] Since an event camera responds to local temporal changes in image intensity its events can be interpreted as a temporal derivative V. Events are accumulated for visualization purposes over a time frame of 0.005 seconds to form a frame similar to a regular camera. These frames are shown in the top left corner of the following video. Green represents a positive value, red a negative one. Beside the temporal derivative, intrinsic camera parameters like optical center and focal length are used to construct a calibration matrix C. This calibration matrix C maps pixel coordinates to spatial coordinates. V and C are used to reconstruct the image intensity I, the spatial Gradient G and the optical flow F. These quantities are also accumulated for visualization and shown in the top right corner, bottom left corner and bottom right corner.
The image intensity is portrayed as a gray scale image. G and F are vector fields in the pixel plane. Each direction of the vectorfield is represented by a color. This mapping is visualised by the annulus in the center. The intensity of the color represents the magnitude of the vectors. They are not comparable between G and F. The approach assumes that the observed scene is static and the camera is fixed in space but can rotate. The rotational velocity R is also estimated and used for the estimation of F, but not shown in the video.
""", textAlign: TextAlign.justify),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        appState.selectVideo(0);
                      },
                      icon: appState.videoIcons[0],
                      label: Text(appState.videoNames[0]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        appState.selectVideo(1);
                      },
                      icon: appState.videoIcons[1],
                      label: Text(appState.videoNames[1]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        appState.selectVideo(2);
                      },
                      icon: appState.videoIcons[2],
                      label: Text(appState.videoNames[2]),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 50),
              Screen(),
              // Container(
              //   height: 400,
              //   width: 600,
              //   color: placeholderColor,
              //   child: SizedBox(child: Text(videoName)),
              // ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(text, style: style),
      ),
    );
  }
}

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);
  @override
  State<Screen> createState() => MyScreenState();
}

class MyScreenState extends State<Screen> {
  // Create a [Player] to control playback.
  late final List<Player> players = [Player(), Player(), Player()];
  // Create a [VideoController] to handle video output from [Player].
  late final List<VideoController> controllers = [
    VideoController(players[0]),
    VideoController(players[1]),
    VideoController(players[2]),
  ];

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose(int index) {
  //   player.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<VideoState>();
    var video = appState.currentVideoFile;
    var index = appState.currentIndex;

    players[index].open(Media(video));

    return Center(
      child: Column(
        children: [
          Text(video),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width * 9.0 / 32.0,
            // Use [Video] widget to display video output.
            child: Video(controller: controllers[index]),
          ),
        ],
      ),
    );
  }
}
