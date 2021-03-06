import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class VideoPlayercustom extends StatefulWidget {
  VideoPlayercustom(this.index, this.documents);
  final int index;
  final dynamic documents;

  @override
  _VideoPlayercustomState createState() => _VideoPlayercustomState();
}

class _VideoPlayercustomState extends State<VideoPlayercustom> {
  @override
  Widget build(BuildContext context) {
    int key = widget.index;
    return BetterPlayerListVideoPlayer(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.documents[widget.index].data()['Video'],
        cacheConfiguration: BetterPlayerCacheConfiguration(
            useCache: true,
            maxCacheSize: 40 * 1024 * 1024,
            maxCacheFileSize: 10 * 1024 * 1024),
      ),
      autoPause: true,
      playFraction: 0.7,
      key: Key(key.toString()),
      configuration: BetterPlayerConfiguration(
        autoPlay: true,
        looping: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableFullscreen: false,
          enableQualities: false,
          enableSubtitles: false,
          enableSkips: false,
          playerTheme: BetterPlayerTheme.material,
          loadingWidget: CircularProgressIndicator(),
        ),
        showPlaceholderUntilPlay: false,
        aspectRatio: 16/9,
        autoDispose: true,
      ),
    );
  }
}
