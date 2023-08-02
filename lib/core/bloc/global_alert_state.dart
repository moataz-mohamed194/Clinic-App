part of 'global_alert_bloc.dart';

class GlobalAlertState {
  final bool isAlertVisible;
  final String? title;
  final String? body;

  GlobalAlertState( {this.title, this.body,required this.isAlertVisible});
}
