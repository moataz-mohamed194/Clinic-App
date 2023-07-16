import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ domain/entities/Nurse.dart';
import '../../ domain/usecases/add_Nurse.dart';
import '../../ domain/usecases/get_all_Nurse.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/string/failures.dart';
import '../../../../core/string/messages.dart';
import 'Nurse_event.dart';
import 'Nurse_state.dart';

class AddGetNurseBloc extends Bloc<NurseEvent, AddGetNurseState> {
  final AddNurseData addNurse;
  final GetNurseData getNurse;

  AddGetNurseBloc({required this.addNurse, required this.getNurse})
      : super(NurseInitial()) {
    on<NurseEvent>((event, emit) async {
      if (event is AddNurseEvent) {
        emit(LoadingNurseState());
        final failureOrDoneMessage = await addNurse(event.nurse);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is GetNurseEvent || event is RefreshNurseEvent) {
        emit(LoadingNurseState());
        final failureOrDoneMessage = await getNurse();
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage));
      }
    });
  }
}

AddGetNurseState _mapFailureOrPostsToStateForAdd(
    Either<Failures, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorNurseState(message: _mapFailureToMessage(failure)),
    (_) => MessageAddGetNurseState(
      message: message,
    ),
  );
}

AddGetNurseState _mapFailureOrPostsToStateForGet(
    Either<Failures, List<Nurse>> either) {
  return either.fold(
    (failure) => ErrorNurseState(message: _mapFailureToMessage(failure)),
    (nurse) => LoadedNurseState(
      nurse: nurse,
    ),
  );
}

String _mapFailureToMessage(Failures failure) {
  switch (failure.runtimeType) {
    case OfflineFailures:
      return SERVER_FAILURE_MESSAGE;
    case OfflineFailures:
      return OFFLINE_FAILURE_MESSAGE;
    default:
      return "Unexpected Error , Please try again later .";
  }
}
