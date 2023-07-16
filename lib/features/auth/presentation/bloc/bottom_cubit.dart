import 'package:bloc/bloc.dart';

class BottomCubit extends Cubit<int> {
  BottomCubit() : super(0);
  changeCurrentPage(int index) {
    emit(index);
  }
}
