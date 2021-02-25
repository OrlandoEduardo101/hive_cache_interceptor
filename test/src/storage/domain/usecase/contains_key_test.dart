
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_cache_interceptor/src/storage/domain/errors/erros.dart';
import 'package:hive_cache_interceptor/src/storage/domain/repositories/storage_repository.dart';
import 'package:hive_cache_interceptor/src/storage/domain/usecases/contains_key.dart';
import 'package:mocktail/mocktail.dart';

class RepositoryMock extends Mock implements IStorageRepository {}

main() {
  var repository = RepositoryMock();
  var usecase = ContainsKey(repository);

  test('Must return true', () async {
    when(repository).calls(#containsKey).thenAnswer((_) async => Right<ReadError, bool>(true));
    var result = await usecase('key');
    expect(result.fold(id, id), true);
  });

  test('Must return error', () async {
    when(repository).calls(#containsKey).thenAnswer((_) async => Left<ReadError, bool>(ReadError()));
    var result = await usecase('key');
    expect(result.fold(id, id), isA<ReadError>());
  });

  test('Must return error invalid key', () async {
    when(repository).calls(#containsKey).thenAnswer((_) async => Right<ReadError, bool>(true));
    var result = await usecase('');
    expect(result.fold(id, id), isA
    <ReadError>());
  });

}