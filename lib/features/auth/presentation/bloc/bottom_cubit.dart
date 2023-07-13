import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class BottomCubit extends Cubit<int> {
  BottomCubit() : super(0);
  changeCurrentPage(int index){
    emit(index);
  }
}
