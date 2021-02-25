import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_cache_interceptor/src/storage/domain/errors/erros.dart';
import 'package:hive_cache_interceptor/src/storage/domain/repositories/storage_repository.dart';
import 'package:hive_cache_interceptor/src/storage/domain/usecases/read.dart';
import 'package:mocktail/mocktail.dart';

class RepositoryMock extends Mock implements IStorageRepository {}

main() {
  var repository = RepositoryMock();
  var usecase = Read(repository);

  test('Must return unit', () async {
    when(repository).calls(#read).thenAnswer((_) async => Right<ReadError, Map>({'key': 'value'}));
    var result = await usecase('key');
    expect(result.fold(id, id), isA<Map>());
  });

  test('Must return error', () async {
    when(repository).calls(#read).thenAnswer((_) async => Left<ReadError, Map>(ReadError()));
    var result = await usecase('key');
    expect(result.fold(id, id), isA<ReadError>());
  });

  test('Must return error invalid key', () async {
    when(repository).calls(#delete).thenAnswer((_) async => Right<ReadError, Map>({'key': 'value'}));
    var result = await usecase('');
    expect(result.fold(id, id), isA<ReadError>());
  });

}