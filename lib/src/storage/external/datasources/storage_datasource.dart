import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/errors/erros.dart';
import '../../infra/datasource/storage_datasource.dart';

class StorageDatasource implements IStorageDatasource {
  Completer<Box> completer = Completer<Box>();
  final HiveInterface _hive;
  String? boxName;

  StorageDatasource(this._hive, {this.boxName});

  void setBoxName(String? value) {
    this.boxName = value;
    _init();
  }

  _init() async {
    await _hive.initFlutter();
    final box = await _hive.openBox('$boxName');
    completer.complete(box);
  }

  @override
  Future<Unit> delete(String key) async {
    var box = await completer.future;
    try {
      await box.delete(key);
      return unit;
    } catch (e) {
      throw DeleteError(message: 'Error delete file: $e');
    }
  }

  @override
  Future<Unit> put(String key, Map value) async {
    var box = await completer.future;
    try {
      await box.put(key, value);
      return unit;
    } catch (e) {
      throw PutError(message: 'Error save file: $e');
    }
  }

  @override
  Future<Map> read(String key) async {
    var box = await completer.future;
    try {
      var response = await box.get(key);
      return response == null ? {} : response;
    } catch (e) {
      throw ReadError(message: 'Error read file: $e');
    }
  }

  @override
  Future<Unit> update(String key, Map value) async {
    var box = await completer.future;
    try {
      await box.put(key, value);
      return unit;
    } catch (e) {
      throw PutError(message: 'Error update file: $e');
    }
  }

  @override
  Future<Unit> clear() async {
    var box = await completer.future;
    try {
      await box.clear();
      return unit;
    } catch (e) {
      throw DeleteError(message: 'Error delete file: $e');
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    var box = await completer.future;
    try {
      // ignore: await_only_futures
      return await box.containsKey(key);
    } catch (e) {
      throw ReadError(message: 'Error read key: $e');
    }
  }
}
