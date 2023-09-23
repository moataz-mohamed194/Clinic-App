import 'dart:developer';

import 'package:clinic/core/string/url.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
part 'socket_state.dart';

class SocketBloc extends Cubit<SocketState> {
  final WebSocketChannel _socket = WebSocketChannel.connect(Uri.parse(
      AppUrl.socketUrl));

  SocketBloc() : super(SocketInitial()) {
    log('socket');
    _socket.ready;

    _socket.stream.forEach((element) {
      print('socket00:$element');

      emit(SocketConnected(message: element));
    });
    _socket.ready.catchError((onError) {
      print('onError:$onError');
      emit(SocketConnectedError(message: onError));
    });
    _socket.ready.onError((error, stackTrace) {
      emit(SocketConnectedError(message: error.toString()));
    });
  }
  sendMessage(String? message) {
    _socket.sink.add(message);
  }
}
