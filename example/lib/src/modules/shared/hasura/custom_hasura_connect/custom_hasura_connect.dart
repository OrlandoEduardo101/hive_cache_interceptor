import 'package:hasura_connect/hasura_connect.dart';
import 'package:hive_cache_interceptor/hive_cache_interceptor.dart';


class CustomHasuraConnect {
  final String url;

  CustomHasuraConnect(this.url);
  HasuraConnect getConnect() {
    return HasuraConnect(
      url,
      interceptors: [
        HiveCacheInterceptor(),
        LogInterceptor(),
      ],
      headers: {},
    );
  }
}