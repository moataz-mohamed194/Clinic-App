import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'global_alert_event.dart';
part 'global_alert_state.dart';

class GlobalAlertBloc extends Bloc<GlobalAlertEvent, GlobalAlertState> {
  GlobalAlertBloc() : super(GlobalAlertState(isAlertVisible: false)) {
    // Register the event handler for GlobalAlertEvent
    on<GlobalAlertEvent>((event, emit) {
      if (event is GlobalAlertShowEvent) {
        emit(GlobalAlertState(isAlertVisible: true, title: event.title,body: event.body ));
      } else if (event is GlobalAlertHideEvent) {
        emit(GlobalAlertState(isAlertVisible: false));
      }
    });
  }
// ... Rest of the code for GlobalAlertBloc
}