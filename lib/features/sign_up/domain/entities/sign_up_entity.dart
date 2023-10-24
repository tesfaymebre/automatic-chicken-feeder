import 'package:equatable/equatable.dart';

class SignUpEntity extends Equatable {
  final String message;

  SignUpEntity({required this.message});

  @override
  List<Object?> get props => [message];
}
