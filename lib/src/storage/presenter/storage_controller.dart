import 'package:dartz/dartz.dart';
import 'package:hasura_cache_interceptor/hasura_cache_interceptor.dart';

import '../domain/errors/erros.dart';
import '../domain/usecases/clear.dart';
import '../domain/usecases/contains_key.dart';
import '../domain/usecases/delete.dart';
import '../domain/usecases/put.dart';
import '../domain/usecases/read.dart';

class StorageController implements IStorageService {
  final IPut _put;
  final IRead _read;
  final IDelete _delete;
  final IClear _clear;
  final IContainsKey _containsKey;

  StorageController(
      this._put, this._read, this._delete, this._clear, this._containsKey);

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
        (l) => throw ReadError(message: '${l.message}'), (r) => r);
  }

  @override
  Future get(String key) async {
    var result = await _read(key);
    return result.fold(
        (l) => throw ReadError(message: '${l.message}'), (r) => r['value']);
  }

  @override
  Future<void> remove(String key) async {
    var result = await _delete(key);
    return result.fold(
        (l) => throw DeleteError(message: '${l.message}'), (r) => r);
  }
}
