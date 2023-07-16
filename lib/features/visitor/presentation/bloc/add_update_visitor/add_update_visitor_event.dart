part of 'add_update_visitor_bloc.dart';

abstract class AddUpdateVisitorEvent extends Equatable {
  const AddUpdateVisitorEvent();

  @override
  List<Object> get props => [];
}

class AddVisitorEvent extends AddUpdateVisitorEvent {
  final Visitor visitor;

  AddVisitorEvent({required this.visitor});

  @override
  List<Object> get props => [visitor];
}

class UpdateVisitorEvent extends AddUpdateVisitorEvent {
  final int visitorId;

  UpdateVisitorEvent({required this.visitorId});

  @override
  List<Object> get props => [visitorId];
}
