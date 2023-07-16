import 'package:equatable/equatable.dart';
import '../../ domain/entities/Fees.dart';

abstract class FeesEvent extends Equatable {
  const FeesEvent();

  @override
  List<Object> get props => [];
}

class AddFeesEvent extends FeesEvent {
  final Fees fees;

  AddFeesEvent({required this.fees});

  @override
  List<Object> get props => [fees];
}

class UpdateFeesEvent extends FeesEvent {
  final Fees fees;

  UpdateFeesEvent({required this.fees});

  @override
  List<Object> get props => [fees];
}

class DeleteFeesEvent extends FeesEvent {
  final int feesId;

  DeleteFeesEvent({required this.feesId});

  @override
  List<Object> get props => [feesId];
}

class GetFeesOfDayEvent extends FeesEvent {
  final String day;

  GetFeesOfDayEvent({required this.day});

  @override
  List<Object> get props => [day];
}

class GetFeesOfMonthEvent extends FeesEvent {
  final String month;

  GetFeesOfMonthEvent({required this.month});

  @override
  List<Object> get props => [month];
}

class RefreshFeesEvent extends FeesEvent {}
