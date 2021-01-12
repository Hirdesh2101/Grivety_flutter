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
          cacheConfiguration: BetterPlayerCacheConfiguration(
              useCache: true,
              maxCacheSize: 50 * 1024 * 1024,
              maxCacheFileSize: 20 * 1024 * 1024),
        ),
        key: Key(widget.index),
        configuration: BetterPlayerConfiguration(
          autoPlay: false,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enableFullscreen: false,
            enableQualities: true,
            enableSkips: false,
          ),
          placeholder: Center(child: CircularProgressIndicator()),
          showPlaceholderUntilPlay: true,
          aspectRatio: 16 / 9,
          autoDispose: true,
        ),
      ),
    );
  }
}
