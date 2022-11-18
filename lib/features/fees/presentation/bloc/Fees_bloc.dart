import 'package:clinic/features/fees/%20domain/usecases/fees_delete.dart';
import 'package:clinic/features/fees/%20domain/usecases/get_fees_of_day.dart';
import 'package:clinic/features/fees/%20domain/usecases/get_fees_of_month.dart';
import 'package:clinic/features/fees/%20domain/usecases/update_fees.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ domain/entities/Fees.dart';
import '../../ domain/usecases/add_fees.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/string/failures.dart';
import '../../../../core/string/messages.dart';
import 'Fees_event.dart';
import 'Fees_state.dart';

class AddUpdateGetFeesBloc extends Bloc<FeesEvent, AddUpdateGetFeesState>{
  final AddFees addFees;
  final UpdateFeesData updateFeesData;
  final GetFeesOfDay getFeesOfDay;
  final GetFeesOfMonth getFeesOfMonth;
  final DeleteFeesData deleteFeesData;

  AddUpdateGetFeesBloc({
    required this.getFeesOfDay,
    required this.getFeesOfMonth,
    required this.addFees,
    required this.updateFeesData,
    required this.deleteFeesData
    }) : super(FeesInitial()){
    on<FeesEvent>((event, emit) async {
      if (event is AddFeesEvent){
        emit(LoadingFeesState());
        final failureOrDoneMessage = await addFees(event.fees);
        emit(_mapFailureOrPostsToStateForAdd(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      }else if(event is UpdateFeesEvent){
        emit(LoadingFeesState());
        final failureOrDoneMessage = await updateFeesData(event.fees);
        emit(_mapFailureOrPostsToStateForAdd(failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      }else if(event is DeleteFeesEvent){
        emit(LoadingFeesState());
        final failureOrDoneMessage = await deleteFeesData(event.feesId);
        emit(_mapFailureOrPostsToStateForAdd (failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }else if(event is GetFeesOfDayEvent){
        emit(LoadingFeesState());
        final failureOrDoneMessage = await getFeesOfDay(event.day);
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage));
      }else if(event is GetFeesOfMonthEvent){
        emit(LoadingFeesState());
        final failureOrDoneMessage = await getFeesOfMonth(event.month);
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage));
      }
    });
  }
}


AddUpdateGetFeesState _mapFailureOrPostsToStateForAdd(Either<Failures, Unit> either, String message) {
  return either.fold(
        (failure) => ErrorFeesState(
        message: _mapFailureToMessage(failure)
    ),
        (_) => MessageAddUpdateGetFeesState(
      message: message,
    ),
  );
}


AddUpdateGetFeesState _mapFailureOrPostsToStateForGet(Either<Failures, List<Fees>> either) {
  return either.fold(
        (failure) => ErrorFeesState(message: _mapFailureToMessage(failure)),
        (fees) => LoadedFeesState(
            fees: fees
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