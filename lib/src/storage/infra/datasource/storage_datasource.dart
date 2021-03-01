import 'package:dartz/dartz.dart';

abstract class IStorageDatasource {
  Future<Unit> delete(String key);
  Future<Unit> clear();
  void setBoxName(String? value);
  Future<Unit> put(String key, Map value);
  Future<Unit> update(String key, Map value);
  Future<Map> read(String key);
  Future<bool> containsKey(String key);
}
