import '../entities/sign_up_entity.dart';
import '../repositories/sign_up_repository.dart';

class SignUpUseCase {
  final SignUpRepository signUpRepository;

  SignUpUseCase({required this.signUpRepository});

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
  }) async {
    try {
      final result = await signUpRepository.createUser(
          full_name: full_name,
          email: email,
          password: password,
          device_id: device_id,
          phoneNumber: phoneNumber,
          city: city,
          subCity: subCity,
          woreda: woreda,
          street: street,
          houseNo: houseNo);

      // Return the entity representing the successful message
      return result;
    } catch (e) {
      print(e.toString());
      // Handle any errors and return an entity representing the failure
      return SignUpEntity(message: "Failed to create feeding schedule");
    }
  }
}
