
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_cache_interceptor/src/storage/domain/errors/erros.dart';
import 'package:hive_cache_interceptor/src/storage/infra/datasource/storage_datasource.dart';
import 'package:hive_cache_interceptor/src/storage/infra/repositories/storage_repository.dart';
import 'package:mocktail/mocktail.dart';

class DatasourceMock extends Mock implements IStorageDatasource {}

main() {
  var datasource = DatasourceMock();
  var repository = StorageRepository(datasource);

  group('put', () {
    test('must return unit', () async {
      when(datasource).calls(#put).thenAnswer((_) async => unit);
      var result = await repository.put('key', {'key': 'value'});
      expect(result.fold((l) => l, (r) => r), isA<Unit>());
    });

    test('must return error', () async {
      when(datasource).calls(#put).thenThrow(Exception());
      var result = await repository.put('key', {'key': 'value'});
      expect(result.fold((l) => l, (r) => r), isA<PutError>());
    });


  });

  group('update', () {
    test('must return unit', () async {
      when(datasource).calls(#update).thenAnswer((_) async => unit);
      var result = await repository.update('key', {'key': 'value'});
      expect(result.fold((l) => l, (r) => r), isA<Unit>());
    });

    test('must return error', () async {
      when(datasource).calls(#update).thenThrow(Exception());
      var result = await repository.update('key', {'key': 'value'});
      expect(result.fold((l) => l, (r) => r), isA<UpdateError>());
    });


  });

  group('delete', () {
    test('must return unit', () async {
      when(datasource).calls(#delete).thenAnswer((_) async => unit);
      var result = await repository.delete('key');
      expect(result.fold((l) => l, (r) => r), isA<Unit>());
    });

    test('must return error', () async {
      when(datasource).calls(#delete).thenThrow(Exception());
      var result = await repository.delete('key');
      expect(result.fold((l) => l, (r) => r), isA<DeleteError>());
    });


  });

  group('read', () {
    test('must return map', () async {
      when(datasource).calls(#read).thenAnswer((_) async => {'key': 'value'});
      var result = await repository.read('key');
      expect(result.fold((l) => l, (r) => r), isA<Map>());
    });

    test('must return error', () async {
      when(datasource).calls(#read).thenThrow(Exception());
      var result = await repository.read('key');
      expect(result.fold((l) => l, (r) => r), isA<ReadError>());
    });


  });

  group('containskey', () {
    test('must return true', () async {
      when(datasource).calls(#containsKey).thenAnswer((_) async => true);
      var result = await repository.containsKey('key');
      expect(result.fold((l) => l, (r) => r), true);
    });

    test('must return false', () async {
      when(datasource).calls(#containsKey).thenAnswer((_) async => false);
      var result = await repository.containsKey('key');
      expect(result.fold((l) => l, (r) => r), false);
    });

    test('must return error', () async {
      when(datasource).calls(#containsKey).thenThrow(Exception());
      var result = await repository.containsKey('key');
      expect(result.fold((l) => l, (r) => r), isA<ReadError>());
    });


  });

  group('clear', () {
    test('must return unit', () async {
      when(datasource).calls(#clear).thenAnswer((_) async => unit);
      var result = await repository.clear();
      expect(result.fold((l) => l, (r) => r), isA<Unit>());
    });

    test('must return error', () async {
      when(datasource).calls(#clear).thenThrow(Exception());
      var result = await repository.delete('key');
      expect(result.fold((l) => l, (r) => r), isA<DeleteError>());
    });


  });

}
