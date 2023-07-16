part of 'visitor_bloc.dart';

abstract class VisitorEvent extends Equatable {
  const VisitorEvent();

  @override
  List<Object> get props => [];
}

class GetAllVisitorsEvent extends VisitorEvent {}

class RefreshVisitorsEvent extends VisitorEvent {}
