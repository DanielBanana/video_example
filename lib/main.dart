import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
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
        title: 'IM App',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 199, 36, 38), // Primary color
          brightness: Brightness.light, // Light or dark theme
          scaffoldBackgroundColor: Colors.grey[255], // Background color
          textTheme: TextTheme(
            headlineLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 228, 108, 110),
            ),
            bodyMedium: TextStyle(fontSize: 18, color: Colors.black),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 244, 195, 195),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        // theme: ThemeData(
        //   useMaterial3: true,
        //   colorScheme: ColorScheme.fromSeed(
        //     seedColor: const Color.fromARGB(255, 199, 36, 38),
        //   ),
        // ),
        home: HomePage(),
      ),
    );
  }
}

class VideoState extends ChangeNotifier {
  List<String> videoNames = ["Shapes", "Poster", "Boxes"];
  List<String> videoFiles = [
    // "assets/video.mp4",
    "assets/shapes_rotation_shorth264.mp4",
    "assets/poster_rotation_shorth264.mp4",
    // "https://github.com/DanielBanana/video_example/raw/refs/heads/main/assets/boxes_rotation_ultra_short.mp4",
    "assets/boxes_rotation_shorth264.mp4",
  ];
  List<Icon> videoIcons = [
    Icon(Icons.play_arrow, color: Colors.black),
    Icon(Icons.play_arrow_outlined, color: Colors.black),
    Icon(Icons.play_arrow_outlined, color: Colors.black),
  ];

  List<bool> loaded = [false, false, false];
  var currentIndex = 0;
  late String current = videoNames[currentIndex];
  late String currentVideoFile = videoFiles[currentIndex];

  void selectVideo(int index) {
    videoIcons[currentIndex] = Icon(
      Icons.play_arrow_outlined,
      color: Colors.black,
    );
    currentIndex = index;
    current = videoNames[index];
    currentVideoFile = videoFiles[index];
    videoIcons[index] = Icon(Icons.play_arrow, color: Colors.black);
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
          BigCard(text: "True Event Based Interacing Maps"),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              """
                      The interacting maps approach uses the signals from a event based camera like the Dynamic Vision Sensor (DVS) as its only real input. An event camera, also known as a neuromorphic camera, silicon retina, or dynamic vision sensor, is an imaging sensor that responds to local changes in brightness. Event cameras do not capture images using a shutter as conventional (frame) cameras do. Instead, each pixel inside an event camera operates independently and asynchronously, reporting changes in brightness as they occur, and staying silent otherwise.
                      Since an event camera responds to local temporal changes in image intensity its events can be interpreted as a temporal derivative V. Events are accumulated for visualization purposes over a time frame of 0.005 seconds to form a frame similar to a regular camera. These frames are shown in the top left corner of the following video. Green represents a positive value, red a negative one.
                      Beside the temporal derivative, intrinsic camera parameters like optical center and focal length are used to construct a calibration tensor C. This calibration tensor C maps pixel coordinates to spatial coordinates with respect to the camera. Each entry of the C contains a vector pointing back to the origina at the camera. V and C are used to reconstruct:
                        the image intensity I,
                        the spatial Gradient G
                        and the optical flow F.
                      These quantities are also accumulated for visualization and shown in the top right corner, bottom left corner and bottom right corner. The calculations happen for each event individually not on a frame by frame basis!
                      The image intensity is portrayed as a gray scale image. G and F are vector fields in the pixel plane. Each direction of the vector field is represented by a color. This mapping is visualised by the annulus in the center. The intensity of the color represents the magnitude of the vectors. They are not comparable between G and F. The approach assumes that the observed scene is static and the camera is fixed in space but can rotate. The rotational velocity R is also estimated and used for the estimation of F, but not shown in the video.
                      """,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodySmall,
            ),
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
                        // appState.loaded[0] = true;
                      },
                      icon: appState.videoIcons[0],
                      label: Text(appState.videoNames[0]),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        appState.selectVideo(1);
                        // appState.loaded[1] = true;
                      },
                      icon: appState.videoIcons[1],
                      label: Text(appState.videoNames[1]),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        appState.selectVideo(2);
                        // appState.loaded[2] = true;
                      },
                      icon: appState.videoIcons[2],
                      label: Text(appState.videoNames[2]),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 50),
              ScreenMK(),
              // Container(
              //   height: 400,
              //   width: 600,
              //   color: placeholderColor,
              //   child: SizedBox(child: Text(videoName)),
              // ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: 50,
                  child: Image(image: AssetImage('SpicesLabLogo.png')),
                ),
              ),
            ],
          ),
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
    final style = theme.textTheme.displaySmall!.copyWith(color: Colors.white);

    return Card(
      color: theme.primaryColor,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(text, style: style, textAlign: TextAlign.center),
      ),
    );
  }
}

class ScreenMK extends StatefulWidget {
  const ScreenMK({super.key});
  @override
  State<ScreenMK> createState() => ScreenMKState();
}

class ScreenMKState extends State<ScreenMK> {
  // Create a [Player] to control playback.

  var loaded = [false, false, false];

  // late final player = Player();

  late final players = [Player(), Player(), Player()];
  // Create a [VideoController] to handle video output from [Player].
  // late final controller = VideoController(player);

  late final controllers = [
    VideoController(players[0]),
    VideoController(players[1]),
    VideoController(players[2]),
  ];

  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (Player p in players) {
      p.dispose();
    }
    super.dispose();
  }

  void loadVideo(int idx, String asset) {
    players[idx].open(Media(asset));
    loaded[idx] = true;
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<VideoState>();
    if (loaded[appState.currentIndex] != true) {
      loadVideo(appState.currentIndex, appState.currentVideoFile);
    }

    return Center(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width * 9.0 / 32.0,
            // Use [Video] widget to display video output.
            child: Video(controller: controllers[appState.currentIndex]),
          ),
        ],
      ),
    );
  }
}
