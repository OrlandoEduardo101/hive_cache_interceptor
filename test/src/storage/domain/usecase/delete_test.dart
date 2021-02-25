
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_cache_interceptor/src/storage/domain/errors/erros.dart';
import 'package:hive_cache_interceptor/src/storage/domain/repositories/storage_repository.dart';
import 'package:hive_cache_interceptor/src/storage/domain/usecases/delete.dart';
import 'package:mocktail/mocktail.dart';

class RepositoryMock extends Mock implements IStorageRepository {}

main() {
  var repository = RepositoryMock();
  var usecase = Delete(repository);

  test('Must return unit', () async {
    when(repository).calls(#delete).thenAnswer((_) async => Right<DeleteError, Unit>(unit));
    var result = await usecase('key');
    expect(result.fold(id, id), isA<Unit>());
  });

  test('Must return error', () async {
    when(repository).calls(#delete).thenAnswer((_) async => Left<DeleteError, Unit>(DeleteError()));
    var result = await usecase('key');
    expect(result.fold(id, id), isA<DeleteError>());
  });

  test('Must return error invalid key', () async {
    when(repository).calls(#delete).thenAnswer((_) async => Right<DeleteError, Unit>(unit));
    var result = await usecase('');
    expect(result.fold(id, id), isA<DeleteError>());
  });

}