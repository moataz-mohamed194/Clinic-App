import 'package:clinic/features/clinic/%20domain/usecases/add_clinic_today.dart';
import 'package:clinic/features/clinic/%20domain/usecases/update_clinic_data.dart';
import 'package:clinic/features/clinic/presentation/bloc/actions_clinic_event.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/Clinic.dart';
import '../../ domain/usecases/get_all_clinic_today.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/string/failures.dart';
import '../../../../core/string/messages.dart';
import 'actions_clinic_state.dart';

class AddUpdateGetClinicBloc
    extends Bloc<ClinicEvent, AddUpdateGetClinicState> {
  final AddClinicData addClinic;
  final UpdateClinicData updateClinic;
  final GetClinicData getClinic;

  AddUpdateGetClinicBloc(
      {required this.addClinic,
      required this.updateClinic,
      required this.getClinic})
      : super(ClinicInitial()) {
    on<ClinicEvent>((event, emit) async {
      if (event is AddClinicEvent) {
        emit(LoadingClinicState());
        final failureOrDoneMessage = await addClinic(event.clinic);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdateClinicEvent) {
        emit(LoadingClinicState());
        final failureOrDoneMessage = await updateClinic(event.clinic);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is GetClinicEvent || event is RefreshClinicEvent) {
        emit(LoadingClinicState());
        final failureOrDoneMessage = await getClinic();
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage));
      }
    });
  }
}

AddUpdateGetClinicState _mapFailureOrPostsToStateForAdd(
    Either<Failures, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorClinicState(message: _mapFailureToMessage(failure)),
    (_) => MessageAddUpdateGetClinicState(
      message: message,
    ),
  );
}

AddUpdateGetClinicState _mapFailureOrPostsToStateForGet(
    Either<Failures, List<Clinic>> either) {
  return either.fold(
    (failure) => ErrorClinicState(message: _mapFailureToMessage(failure)),
    (clinic) => LoadedClinicState(
      clinic: clinic,
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
