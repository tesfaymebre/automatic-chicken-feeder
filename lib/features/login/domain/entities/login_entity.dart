import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LoginEntity extends Equatable {
  final String email;
  final String password;
  const LoginEntity({required this.email, required this.password}) : super();

  @override
  List<Object?> get props => [email, password];
}
