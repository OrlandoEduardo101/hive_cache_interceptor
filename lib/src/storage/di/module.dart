import 'package:hive_cache_interceptor/src/storage/domain/usecases/clear.dart';
import 'package:hive_cache_interceptor/src/storage/domain/usecases/contains_key.dart';
import 'package:hive_cache_interceptor/src/storage/domain/usecases/delete.dart';
import 'package:hive_cache_interceptor/src/storage/domain/usecases/put.dart';
import 'package:hive_cache_interceptor/src/storage/domain/usecases/read.dart';
import 'package:hive_cache_interceptor/src/storage/domain/usecases/update.dart';
import 'package:hive_cache_interceptor/src/storage/external/datasources/storage_datasource.dart';
import 'package:hive_cache_interceptor/src/storage/infra/repositories/storage_repository.dart';
import 'package:hive_cache_interceptor/src/storage/presenter/storage_controller.dart';
import 'package:http/http.dart';

import 'injection.dart' as sl;

void startModule([Client Function()? client]) {
  //domain
  sl.register(Put(sl.get()));
  sl.register(Read(sl.get()));
  sl.register(ContainsKey(sl.get()));
  sl.register(Update(sl.get()));
  sl.register(Delete(sl.get()));
  sl.register(Clear(sl.get()));

  //repository
  sl.register(StorageRepository(sl.get()));

  //datasource
  sl.register(StorageDatasource(sl.get()));

  //presenter
  sl.register(StorageController(sl.get(), sl.get(), sl.get(), sl.get(), sl.get(),));
}
