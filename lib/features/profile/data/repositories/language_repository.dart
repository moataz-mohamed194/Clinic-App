import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../datasources/language_locale_data_source.dart';
import '../../domain/repositories/base_language_repository.dart';

class LanguageRepository implements BaseLanguageRepository {
  final BaseLanguageLocaleDataSource languageLocaleDataSource;

  const LanguageRepository({required this.languageLocaleDataSource});

  @override
  Future<Either<Failures, String>> changeLanguage(
      {required String languageCode}) async {
    try {
      final languageIsChanged = await languageLocaleDataSource.changeLanguage(
          languageCode: languageCode);
      return Right(languageIsChanged);
    } catch (e) {
      return Left(OfflineFailures());
    }
  }
}
