import '../entities/sign_up_entity.dart';

abstract class SignUpRepository {
  Future<SignUpEntity> createUser({
    required String full_name,
    required String email,
    required String password,
    required String device_id,
    required String phoneNumber,
    required String city,
    required String subCity,
    required String woreda,
    required String street,
    required String houseNo,
  });
}
