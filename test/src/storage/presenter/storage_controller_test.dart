import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_cache_interceptor/src/storage/domain/errors/erros.dart';
import 'package:hive_cache_interceptor/src/storage/domain/usecases/clear.dart';
import 'package:hive_cache_interceptor/src/storage/domain/usecases/contains_key.dart';
import 'package:hive_cache_interceptor/src/storage/domain/usecases/delete.dart';
import 'package:hive_cache_interceptor/src/storage/domain/usecases/put.dart';
import 'package:hive_cache_interceptor/src/storage/domain/usecases/read.dart';
import 'package:hive_cache_interceptor/src/storage/presenter/storage_controller.dart';
import 'package:mocktail/mocktail.dart';

class PutMock extends Mock implements IPut {}

class DeleteMock extends Mock implements IDelete {}

class ClearMock extends Mock implements IClear {}

class ReadMock extends Mock implements IRead {}

class ContainesKeyMock extends Mock implements IContainsKey {}

main() {
  var _put = PutMock();
  var _delete = DeleteMock();
  var _read = ReadMock();
  var _containsKey = ContainesKeyMock();
  var _clear = ClearMock();
  var controller = StorageController();

  group('put', () {
    test('must return unit', () async {
      when(_put)
        .calls(#call)
        .thenAnswer((_) async => Right<PutError, Unit>(unit));
      var result = controller.put('key', {'key': 'value'});
      expect(result, completes);
    });

    /*test('must return error', () async {
      when(_put)
        .calls(#call)
        .thenAnswer((_) async => Left<PutError, Unit>(PutError()));
    var result = await controller.put('key', {'key': 'value'});
    expect(result, throwsA(isA<PutError>()));
    });*/

  });

  group('delete', () {
    test('must return unit', () async {
      when(_delete)
        .calls(#call)
        .thenAnswer((_) async => Right<DeleteError, Unit>(unit));
    var result = controller.remove('key');
    expect(result, completes);
    });

  });

  group('clear', () {
    test('must return unit', () async {
      when(_clear)
        .calls(#call)
        .thenAnswer((_) async => Right<DeleteError, Unit>(unit));
    var result = await controller.clear();
    expect(result, isA<Unit>());
    });

  });

  group('read', () {
    test('must return unit', () async {
      when(_read)
        .calls(#call)
        .thenAnswer((_) async => Right<ReadError, Map>({ 'value': {'key': 'value'}}));
    var result = await controller.get('key');
    expect(result, isA<Map>());
    });

  });

  group('containsKey', () {
    test('must return true', () async {
      when(_containsKey)
        .calls(#call)
        .thenAnswer((_) async => Right<ReadError, bool>(true));
    var result = await controller.containsKey('key');
    expect(result, true);
    });

    test('must return true', () async {
      when(_containsKey)
        .calls(#call)
        .thenAnswer((_) async => Right<ReadError, bool>(false));
    var result = await controller.containsKey('key');
    expect(result, false);
    });

  });
}
