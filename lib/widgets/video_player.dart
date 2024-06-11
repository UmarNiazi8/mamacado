import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String url;
  const VideoPlayer({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  YoutubePlayerController? _controller;
  @override
  //initialize for taking UID of video and it is method
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(widget.url);
//intitializing controller
    _controller = YoutubePlayerController(
        initialVideoId: videoID!, flags: YoutubePlayerFlags(autoPlay: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print("dsghsdgsdhhds");
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
        return Future.value(true);
      },
      child: Center(
        child: YoutubePlayer(
          controller: _controller!,
          showVideoProgressIndicator: true,
          // bottomActions: [
          //   CurrentPosition(),
          //   ProgressBar(
          //     isExpanded: true,
          //     colors: ProgressBarColors(
          //         playedColor: Colors.amber, handleColor: Colors.amberAccent),
          //   ),
          //   PlaybackSpeedButton(
          //     icon: Icon(Icons.play_arrow),
          //   ),
          //   FullScreenButton(
          //     color: Colors.white,
          //   ),
          //   PlayPauseButton(
          //     bufferIndicator: Icon(Icons.play_arrow),
          //   )
          // ],
        ),
      ),
    );
  }
}
