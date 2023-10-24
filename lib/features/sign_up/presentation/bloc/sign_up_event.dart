part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends SignUpEvent {
  final String full_name;
  final String email;
  final String password;
  final String device_id;
  final String phoneNumber;
  final String city;
  final String subCity;
  final String woreda;
  final String street;
  final String houseNo;

  CreateUserEvent({
    required this.full_name,
    required this.email,
    required this.password,
    required this.device_id,
    required this.phoneNumber,
    required this.city,
    required this.subCity,
    required this.woreda,
    required this.street,
    required this.houseNo,
  });

  @override
  List<Object> get props => [
        full_name,
        email,
        password,
        device_id,
        phoneNumber,
        city,
        subCity,
        woreda,
        street,
        houseNo
      ];
}
