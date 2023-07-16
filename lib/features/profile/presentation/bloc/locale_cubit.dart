import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/change_language_use_case.dart';


class LocaleCubit extends Cubit<String> {
  final ChangeLanguageUseCase changeLanguageUseCase;
  final String cubitLanguage;
  LocaleCubit( {required this.cubitLanguage,required this.changeLanguageUseCase}) : super(cubitLanguage);
  String currentLanguageCode = 'en';

  Future<void> _changeLanguage(String languageCode) async {
    final response = await changeLanguageUseCase.call(languageCode);
    response.fold((failure) => debugPrint(languageCode.toString()), (value) {
      currentLanguageCode = languageCode;
      emit(languageCode);
    });
  }

  void toEnglish() => _changeLanguage('en');

  void toArabic() => _changeLanguage('ar');
}
