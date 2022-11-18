import 'package:clinic/features/auth/%20domain/usecases/login_usecases.dart';
import 'package:clinic/features/auth/presentation/bloc/login_event.dart';
import 'package:clinic/features/auth/presentation/bloc/login_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/string/failures.dart';
import '../../../../core/string/messages.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final LoginUseCases loginMethod;

  LoginBloc({
    required this.loginMethod
  }) : super(LoginInitial()){
    on<LoginEvent>((event, emit) async {
      if (event is LoginMethodEvent){
        emit(LoadingLoginState());
        final failureOrDoneMessage = await loginMethod(event.login);
        emit(_mapFailureOrPostsToStateForAdd(failureOrDoneMessage, LOGIN_SUCCESS_MESSAGE));
      }
    });
  }

  LoginState _mapFailureOrPostsToStateForAdd(Either<Failures, Unit> either, String message) {
    return either.fold(
          (failure) => ErrorLoginState(
          message: _mapFailureToMessage(failure)
      ),
          (_) => MessageLoginState(
        message: message,
      ),
    );
  }

  String _mapFailureToMessage(Failures failure) {
    switch (failure.runtimeType) {
      case CheckDataFailures:
        return LOGIN_FAILURE_MESSAGE;
      case OfflineFailures:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailures:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
