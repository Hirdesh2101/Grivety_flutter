import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:better_player/better_player.dart';

class VideoPlayercustom extends StatefulWidget {
  VideoPlayercustom(this.index);
  final String index;

  @override
  _VideoPlayercustomState createState() => _VideoPlayercustomState();
}

class _VideoPlayercustomState extends State<VideoPlayercustom> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayerListVideoPlayer(
        BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
        ),
        key: Key(widget.index),
        configuration: BetterPlayerConfiguration(
          deviceOrientationsOnFullScreen: const [
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown
          ],
          autoPlay: false,
          placeholder:
              Center(child: CircularProgressIndicator()),
          showPlaceholderUntilPlay: true,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}