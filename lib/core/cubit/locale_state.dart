part of 'locale_cubit.dart';

abstract class LocaleState extends Equatable {
  final Locale locale;

  const LocaleState({required this.locale});

  @override
  List<Object> get props => [locale];
}

class ChangeLocaleState extends LocaleState {
  ChangeLocaleState({required Locale locale}) : super(locale: locale);
  // const ChangeLocaleState({required super.locale});
}
