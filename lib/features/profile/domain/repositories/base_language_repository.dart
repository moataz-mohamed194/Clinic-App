import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class BaseLanguageRepository {
  Future<Either<Failures, String>> changeLanguage(
      {required String languageCode});
}
