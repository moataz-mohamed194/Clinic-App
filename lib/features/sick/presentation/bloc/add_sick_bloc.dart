import 'package:clinic/features/sick/%20domain/usecases/add_sick_report.dart';
import 'package:clinic/features/sick/%20domain/usecases/get_all_sicks.dart';
import 'package:clinic/features/sick/%20domain/usecases/update_sick_as_entered.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_event.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/sick.dart';
import '../../ domain/usecases/add _sick.dart';
import '../../ domain/usecases/get_sicks_based_on_user.dart';
import '../../ domain/usecases/update_sick.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/string/failures.dart';
import '../../../../core/string/messages.dart';

class AddUpdateGetSickBloc
    extends Bloc<AddUpdateGetSickEvent, AddUpdateGetSickState> {
  final AddSick addSick;
  final UpdateSick updateSick;
  final UpdateSickAsEntered updateSickAsEntered;
  final AddSickReport addSickReport;
  final GetAllSick getSick;
  final GetSickBasedOnUser getSickBasedOnUser;

  AddUpdateGetSickBloc(
      {required this.addSick,
      required this.updateSick,
      required this.addSickReport,
      required this.updateSickAsEntered,
      required this.getSickBasedOnUser,
      required this.getSick})
      : super(SickInitial()) {
    on<AddUpdateGetSickEvent>((event, emit) async {
      if (event is AddSickEvent) {
        emit(LoadingSicksState());
        final failureOrDoneMessage = await addSick(event.sick);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is AddSickReportEvent) {
        emit(LoadingSicksState());
        final failureOrDoneMessage =
            await addSickReport(event.id, event.report);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdateSickEvent) {
        emit(LoadingSicksState());
        final failureOrDoneMessage = await updateSick(event.sickId);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is UpdateSickAsEnteredEvent) {
        emit(LoadingSicksState());
        final failureOrDoneMessage = await updateSickAsEntered(event.sickId);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is GetSickEvent || event is RefreshSickEvent) {
        emit(LoadingSicksState());
        final failureOrDoneMessage = await getSick();
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage));
      } else if (event is GetSickBasedOnUserEvent ||
          event is RefreshSickEvent) {
        emit(LoadingSicksState());
        final failureOrDoneMessage = await getSickBasedOnUser();
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage));
      }
    });
  }
}

AddUpdateGetSickState _mapFailureOrPostsToStateForAdd(
    Either<Failures, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorSicksState(message: _mapFailureToMessage(failure)),
    (_) => MessageAddUpdateGetSickState(
      message: message,
    ),
  );
}

AddUpdateGetSickState _mapFailureOrPostsToStateForGet(
    Either<Failures, List<Sick>> either) {
  return either.fold(
    (failure) => ErrorSicksState(message: _mapFailureToMessage(failure)),
    (sicks) => LoadedSicksState(
      sicks: sicks,
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
