import 'package:clinic/features/user/presentation/bloc/user_event.dart';
import 'package:clinic/features/user/presentation/bloc/user_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/string/failures.dart';
import '../../../../core/string/messages.dart';
import '../../domain/usecases/add_user.dart';
import '../../domain/usecases/edit_user.dart';

class AddUpdateUserBloc extends Bloc<AddUpdateUserEvent, AddUpdateUserState> {
  final AddUser addUser;
  final UpdateUser updateUser;

  AddUpdateUserBloc({required this.addUser, required this.updateUser})
      : super(UserInitial()) {
    on<AddUpdateUserEvent>((event, emit) async {
      if (event is AddUserEvent) {
        emit(LoadingUsersState());
        final failureOrDoneMessage = await addUser(event.user);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdateUserEvent) {
        emit(LoadingUsersState());
        final failureOrDoneMessage = await updateUser(event.userId, event.user);
        emit(_mapFailureOrPostsToStateForAdd(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      }
    });
  }
}

AddUpdateUserState _mapFailureOrPostsToStateForAdd(
    Either<Failures, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorUsersState(message: _mapFailureToMessage(failure)),
    (_) => MessageAddUpdateUserState(
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
