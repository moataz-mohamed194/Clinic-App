import 'package:bloc/bloc.dart';

class EyesCubit extends Cubit<bool> {
  EyesCubit() : super(true);
  changeEyes() {
    emit(!state);
  }
}
