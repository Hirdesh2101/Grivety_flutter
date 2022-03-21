import 'dart:async';
import 'package:video_player/video_player.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pedantic/pedantic.dart';
import './cacheservice.dart';

class Video {
  String url;

  VideoPlayerController? controller;
  BaseCacheManager? _cacheManager;

  Video({
    required this.url,
  });

  Video.fromJson(Map<dynamic, dynamic> json) : url = json['Video'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Video'] = url;
    return data;
  }

  Future<void> loadController() async {
    {
      _cacheManager ??= CustomCacheManager.instance;
      final fileInfo = await _cacheManager?.getFileFromCache(url);
      if (fileInfo == null) {
        // print('[VideoControllerService]: No video in cache');

        // print('[VideoControllerService]: Saving video to cache');
        unawaited(_cacheManager!.downloadFile(url));
        controller = VideoPlayerController.network(url);
        await controller?.initialize();
        controller?.setLooping(true);
      } else {
        // print('[VideoControllerService]: Loading video from cache');
        controller = VideoPlayerController.file(fileInfo.file);
        await controller?.initialize();
        controller?.setLooping(true);
      }
    }
  }

  Future<void> dispose() async {
    controller?.dispose();
  }
}
