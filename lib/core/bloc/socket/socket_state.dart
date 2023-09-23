part of 'socket_bloc.dart';

class SocketState extends Equatable {
const SocketState();

@override
List<Object> get props => [];
}
class SocketInitial extends SocketState {}
class SocketDisconnected extends SocketState {}
class SocketConnected extends SocketState {
  final String message;

  const SocketConnected({required this.message});

  @override
  List<Object> get props => [message];
}


class SocketConnectedError extends SocketState {
  final String message;

  const SocketConnectedError({required this.message});

  @override
  List<Object> get props => [message];
}