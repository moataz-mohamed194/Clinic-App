import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {}

class OfflineFailures extends Failures {
  @override
  List<Object?> get props => [];
}

class CheckDataFailures extends Failures {
  @override
  List<Object?> get props => [];
}

class FailuresLoginFailures extends Failures {
  @override
  List<Object?> get props => [];
}
