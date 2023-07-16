import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../repositories/base_language_repository.dart';


class ChangeLanguageUseCase{
  final BaseLanguageRepository repository;

  ChangeLanguageUseCase(this.repository);

  Future<Either<Failures, String>> call(String language) async{
    return await repository.changeLanguage(languageCode:language);
  }
}