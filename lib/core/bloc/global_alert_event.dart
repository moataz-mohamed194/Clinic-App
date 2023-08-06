part of 'global_alert_bloc.dart';

// enum GlobalAlertEvent { show, hide }
abstract class GlobalAlertEvent extends Equatable {
  const GlobalAlertEvent();

  @override
  List<Object> get props => [];
}

class GlobalAlertShowEvent extends GlobalAlertEvent {
  final String? title;
  final String? body;

  GlobalAlertShowEvent({this.title, this.body});

  @override
  List<Object> get props => [];
}

class GlobalAlertHideEvent extends GlobalAlertEvent {}
