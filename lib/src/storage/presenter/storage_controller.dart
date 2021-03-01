import 'package:dartz/dartz.dart';
import 'package:hasura_cache_interceptor/hasura_cache_interceptor.dart';
import 'package:hive_cache_interceptor/src/storage/di/module.dart';
import 'package:hive_cache_interceptor/src/storage/infra/datasource/storage_datasource.dart';

import '../domain/errors/erros.dart';
import '../domain/usecases/clear.dart';
import '../domain/usecases/contains_key.dart';
import '../domain/usecases/delete.dart';
import '../domain/usecases/put.dart';
import '../domain/usecases/read.dart';
import '../di/injection.dart' as sl;

class StorageController implements IStorageService {
  late final IPut _put;
  late final IRead _read;
  late final IDelete _delete;
  late final IClear _clear;
  late final IContainsKey _containsKey;
  final String? boxName;

  //String? get getBoxName => boxName;

  StorageController({this.boxName}) {
    startModule();
    sl.get<IStorageDatasource>().setBoxName(boxName);
    _put = sl.get<IPut>();
    _read = sl.get<IRead>();
    _delete = sl.get<IDelete>();
    _clear = sl.get<IClear>();
    _containsKey = sl.get<IContainsKey>();
  }

  @override
  Future<void> put(String key, dynamic value) async {
    var result;
    result = await _put(key, {'value': value});

    return result.fold(
        (l) => throw PutError(message: '${l.message}'), (r) => r);
  }

  @override
  Future<Unit> clear() async {
    var result = await _clear();
    return result.fold(
        (l) => throw DeleteError(message: '${l.message}'), (r) => r);
  }

  @override
  Future<bool> containsKey(String key) async {
    var result = await _containsKey(key);
    return result.fold(
        (l) => throw ReadError(message: '${l.message}'), 
        (r) => r);
  }

  @override
  Future get(String key) async {
    var result = await _read(key);
    return result.fold(
        (l) => throw ReadError(message: '${l.message}'), 
        (r) => r['value']);
  }

  @override
  Future<void> remove(String key) async {
    var result = await _delete(key);
    return result.fold(
        (l) => throw DeleteError(message: '${l.message}'), (r) => r);
  }
}
