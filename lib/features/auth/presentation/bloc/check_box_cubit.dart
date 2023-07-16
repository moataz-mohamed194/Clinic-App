import 'package:bloc/bloc.dart';

class CheckBoxCubit extends Cubit<bool> {
  CheckBoxCubit() : super(false);

  changeCheckBoxCubit() {
    emit(!state);
  }
}
