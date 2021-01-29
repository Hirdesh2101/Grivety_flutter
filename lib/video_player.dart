import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:shimmer/shimmer.dart';

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
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayerListVideoPlayer(
        BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          widget.documents[widget.index].data()['Video'],
          cacheConfiguration: BetterPlayerCacheConfiguration(
              useCache: true,
              maxCacheSize: 40 * 1024 * 1024,
              maxCacheFileSize: 10 * 1024 * 1024),
        ),
        key: Key(key.toString()),
        configuration: BetterPlayerConfiguration(
          autoPlay: false,
          looping: false,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enableFullscreen: false,
            enableQualities: true,
            enableSkips: false,
            playerTheme: BetterPlayerTheme.material,
            loadingWidget: Shimmer.fromColors(
              enabled: true,
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                color: Colors.white60,
              )),
          ),
          placeholder: Shimmer.fromColors(
              enabled: true,
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                color: Colors.white60,
              )),
          showPlaceholderUntilPlay: false,
          //aspectRatio: 16 / 9,
          autoDispose: true,
        ),
      ),
    );
  }
}
