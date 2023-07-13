import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
// import '../../../../core/usecases/usecase.dart';
// import '../../../../core/utils/app_strings.dart';
// import '../../domain/usecases/change_language_use_case.dart';
// import '../../domain/usecases/get_saved_language_use_case.dart';
import '../string/language.dart';
part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit(LocaleState initialState) : super(initialState);



  Future<void> _changeLanguage(String languageCode) async {
    // final response = await changeLanguageUseCase.call(languageCode);
    // response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
    //   currentLanguageCode = languageCode;
    //   emit(ChangeLocaleState(locale: Locale(currentLanguageCode)));
    // });
  }

  void toEnglish() => _changeLanguage(AppLanguage.englishCode);

  void toArabic() => _changeLanguage(AppLanguage.arabicCode);
}
