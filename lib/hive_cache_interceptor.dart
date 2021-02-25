library hive_cache_interceptor;

import 'package:hasura_cache_interceptor/hasura_cache_interceptor.dart';
import './src/storage/di/injection.dart' as sl;

class HiveCacheInterceptor extends CacheInterceptor {
  HiveCacheInterceptor([String? boxName = "storage-box"])
      : assert(boxName != null),
        super(sl.get<IStorageService>());
}
