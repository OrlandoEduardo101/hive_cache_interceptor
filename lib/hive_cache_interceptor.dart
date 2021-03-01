library hive_cache_interceptor;

import 'package:hasura_cache_interceptor/hasura_cache_interceptor.dart';
import 'package:hive_cache_interceptor/src/storage/presenter/storage_controller.dart';

class HiveCacheInterceptor extends CacheInterceptor {
  HiveCacheInterceptor([String? boxName = "storage-box"])
      : assert(boxName != null),
        super(StorageController(boxName: boxName));
}
