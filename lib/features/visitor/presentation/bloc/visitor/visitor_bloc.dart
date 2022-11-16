import 'package:bloc/bloc.dart';
import 'package:clinic/features/visitor/%20domain/entities/visitor.dart';
import 'package:clinic/features/visitor/%20domain/usecases/get_all_visitor_today.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/string/failures.dart';

part 'visitor_event.dart';
part 'visitor_state.dart';

class VisitorBloc extends Bloc<VisitorEvent, VisitorState> {
  final GetAllVisitorToday getAllVisitors;
  VisitorBloc({required this.getAllVisitors}) :
   super(VisitorInitial()) {
    on<VisitorEvent>((event, emit) async{
      if (event is GetAllVisitorsEvent || event is RefreshVisitorsEvent) {
      //   emit(LoadingVisitorsState());
      //
      //   final failureOrVisitors = await getAllVisitors();
      //   emit(_mapFailureOrPostsToState(failureOrVisitors));
      // } else if (event is RefreshVisitorsEvent) {
        try {
          emit(LoadingVisitorsState());
          final failureOrVisitors = await getAllVisitors();
          emit(_mapFailureOrPostsToState(failureOrVisitors));
        }catch(e){
          print(e);
        }
      }
    });
  }
}

VisitorState _mapFailureOrPostsToState(Either<Failures, List<Visitor>> either) {
    return either.fold(
      (failure) => ErrorVisitorssState(message: _mapFailureToMessage(failure)),
      (visitor) => LoadedVisitorsState(
         visitors: visitor,
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
