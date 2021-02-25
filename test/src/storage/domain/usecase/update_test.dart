
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_cache_interceptor/src/storage/domain/errors/erros.dart';
import 'package:hive_cache_interceptor/src/storage/domain/repositories/storage_repository.dart';
import 'package:hive_cache_interceptor/src/storage/domain/usecases/update.dart';
import 'package:mocktail/mocktail.dart';

class RepositoryMock extends Mock implements IStorageRepository {}

main() {
  var repository = RepositoryMock();
  var usecase = Update(repository);

  test('Must return unit', () async {
    when(repository).calls(#update).thenAnswer((_) async => Right<UpdateError, Unit>(unit));
    var result = await usecase('key', {'key': 'value'});
    expect(result.fold(id, id), isA<Unit>());
  });

  test('Must return error', () async {
    when(repository).calls(#update).thenAnswer((_) async => Left<UpdateError, Unit>(UpdateError()));
    var result = await usecase('key', {'key': 'value'});
    expect(result.fold(id, id), isA<UpdateError>());
  });

  test('Must return error invalid key', () async {
    when(repository).calls(#update).thenAnswer((_) async => Right<UpdateError, Unit>(unit));
    var result = await usecase('', {'key': 'value'});
    expect(result.fold(id, id), isA<UpdateError>());
  });

}
