part of 'visitor_bloc.dart';

abstract class VisitorState extends Equatable {
  const VisitorState();

  @override
  List<Object> get props => [];
}

class VisitorInitial extends VisitorState {}

class LoadingVisitorsState extends VisitorState {}

class LoadedVisitorsState extends VisitorState {
  final List<Visitor> visitors;

  LoadedVisitorsState({required this.visitors});

  @override
  List<Object> get props => [visitors];
}

class ErrorVisitorssState extends VisitorState {
  final String message;

  ErrorVisitorssState({required this.message});

  @override
  List<Object> get props => [message];
}
