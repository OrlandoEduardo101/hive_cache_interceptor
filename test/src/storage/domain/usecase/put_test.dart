
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_cache_interceptor/src/storage/domain/errors/erros.dart';
import 'package:hive_cache_interceptor/src/storage/domain/repositories/storage_repository.dart';
import 'package:hive_cache_interceptor/src/storage/domain/usecases/put.dart';
import 'package:mocktail/mocktail.dart';

class RepositoryMock extends Mock implements IStorageRepository {}

main() {
  var repository = RepositoryMock();
  var usecase = Put(repository);

  test('Must return unit', () async {
    when(repository).calls(#put).thenAnswer((_) async => Right<PutError, Unit>(unit));
    var result = await usecase('key', {'key': 'value'});
    expect(result.fold(id, id), isA<Unit>());
  });

  test('Must return error', () async {
    when(repository).calls(#put).thenAnswer((_) async => Left<PutError, Unit>(PutError()));
    var result = await usecase('key', {'key': 'value'});
    expect(result.fold(id, id), isA<PutError>());
  });

  test('Must return error invalid key', () async {
    when(repository).calls(#put).thenAnswer((_) async => Right<PutError, Unit>(unit));
    var result = await usecase('', {'key': 'value'});
    expect(result.fold(id, id), isA<PutError>());
  });

}
