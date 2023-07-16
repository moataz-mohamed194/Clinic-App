import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class AddUpdateUserEvent extends Equatable {
  const AddUpdateUserEvent();

  @override
  List<Object> get props => [];
}

class AddUserEvent extends AddUpdateUserEvent {
  final User user;

  AddUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class UpdateUserEvent extends AddUpdateUserEvent {
  final int userId;
  final User user;
  UpdateUserEvent({required this.userId, required this.user});

  @override
  List<Object> get props => [userId, user];
}
