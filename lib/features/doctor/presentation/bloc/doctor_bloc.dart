import 'package:clinic/features/doctor/%20domain/usecases/add_doctor.dart';
import 'package:clinic/features/doctor/%20domain/usecases/get_all_doctors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ domain/entities/Doctor.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/string/failures.dart';
import '../../../../core/string/messages.dart';
import 'doctor_event.dart';
import 'doctor_state.dart';

class AddGetDoctorBloc extends Bloc<DoctorEvent, AddGetDoctorState>{
  final AddDoctorData addDoctor;
  final GetDoctorData getDoctor;

  AddGetDoctorBloc({
    required this.addDoctor,
    required this.getDoctor}) : super(DoctorInitial()){
    on<DoctorEvent>((event, emit) async {
      if (event is AddDoctorEvent){
        emit(LoadingDoctorState());
        final failureOrDoneMessage = await addDoctor(event.doctor);
        emit(_mapFailureOrPostsToStateForAdd(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      }else if(event is GetDoctorEvent || event is RefreshDoctorEvent){
        emit(LoadingDoctorState());
        final failureOrDoneMessage = await getDoctor();
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage));
      }
    });
  }
}


AddGetDoctorState _mapFailureOrPostsToStateForAdd(Either<Failures, Unit> either, String message) {
  return either.fold(
        (failure) => ErrorDoctorState(
        message: _mapFailureToMessage(failure)
    ),
        (_) => MessageAddGetDoctorState(
      message: message,
    ),
  );
}

AddGetDoctorState _mapFailureOrPostsToStateForGet(Either<Failures, List<Doctor>> either) {
  return either.fold(
        (failure) => ErrorDoctorState(message: _mapFailureToMessage(failure)),
        (doctor) => LoadedDoctorState(
      doctor: doctor,
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