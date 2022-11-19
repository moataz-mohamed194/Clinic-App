import 'package:equatable/equatable.dart';

import '../../ domain/entities/sick.dart';

abstract class AddUpdateGetSickEvent extends Equatable{
  const AddUpdateGetSickEvent();

  @override
  List<Object> get props => [];
}

class AddSickEvent extends AddUpdateGetSickEvent{
  final Sick sick;

  AddSickEvent({required this.sick});

  @override
  List<Object> get props => [sick];
}


class UpdateSickEvent extends AddUpdateGetSickEvent{
  final int sickId;

  UpdateSickEvent({required this.sickId});

  @override
  List<Object> get props => [sickId];
}
class GetSickBasedOnUserEvent extends AddUpdateGetSickEvent{

}


class GetSickEvent extends AddUpdateGetSickEvent{}


class RefreshSickEvent extends AddUpdateGetSickEvent {}
