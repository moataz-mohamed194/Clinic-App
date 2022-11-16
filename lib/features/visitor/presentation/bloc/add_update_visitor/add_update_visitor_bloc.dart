import 'package:bloc/bloc.dart';
import 'package:clinic/core/string/messages.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../ domain/entities/visitor.dart';
import '../../../ domain/usecases/add_visitor_today.dart';
import '../../../ domain/usecases/update_visitor_today.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/string/failures.dart';

part 'add_update_visitor_event.dart';
part 'add_update_visitor_state.dart';

class AddUpdateVisitorBloc extends Bloc<AddUpdateVisitorEvent, AddUpdateVisitorState> {
  final AddVisitorToday addVisitor;
  final UpdateVisitorToday updateVisitor;
  AddUpdateVisitorBloc({
    required this.addVisitor,
    required this.updateVisitor
  }) : super(AddUpdateVisitorInitial()) {
    on<AddUpdateVisitorEvent>((event, emit) async{
      if (event is AddVisitorEvent){
        emit(LoadingAddUpdateVisitorState());
        final failureOrDoneMessage = await addVisitor(event.visitor);

        emit(_mapFailureOrPostsToState(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      }else if (event is UpdateVisitorEvent){
        emit(LoadingAddUpdateVisitorState());
        final failureOrDoneMessage = await updateVisitor(event.visitorId);

        emit(_mapFailureOrPostsToState(failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      }
    });
  }
}

  AddUpdateVisitorState _mapFailureOrPostsToState(Either<Failures, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddUpdateVisitorState(
        message: _mapFailureToMessage(failure)
        ),
      (_) => MessageAddUpdateVisitorState(
         message: message,
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
