import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static const key1 = 'Video_Key';
  static const key2 = 'Image_key';
  static CacheManager instance = CacheManager(
    Config(
      key1,
      stalePeriod: const Duration(days: 2),
      maxNrOfCacheObjects: 25,
      repo: JsonCacheInfoRepository(databaseName: key1),
      //fileSystem: IOFileSystem(key),
      fileService: HttpFileService(),
    ),
  );
  static CacheManager instance2 = CacheManager(
    Config(
      key2,
      stalePeriod: const Duration(days: 2),
      maxNrOfCacheObjects: 35,
      repo: JsonCacheInfoRepository(databaseName: key2),
      //fileSystem: IOFileSystem(key),
      fileService: HttpFileService(),
    ),
  );
}
