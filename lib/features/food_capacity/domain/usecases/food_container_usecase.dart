import '../entities/food_container_entity.dart';
import '../repositories/food_container_repository.dart';

class FoodContainerUseCase {
  final FoodContainerRepository foodContainerRepository;

  FoodContainerUseCase({required this.foodContainerRepository});

  Future<FoodContainerEntity> getFoodContainerData() async {
    return await foodContainerRepository.getFoodContainerData();
  }
}
