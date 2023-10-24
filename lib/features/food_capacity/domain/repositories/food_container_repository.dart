import 'package:chicken_feeder/features/food_capacity/domain/entities/food_container_entity.dart';
import 'package:chicken_feeder/features/home_page/domain/entities/feeding_schedule_entity.dart';

abstract class FoodContainerRepository {
  Future<FoodContainerEntity> getFoodContainerData();
}
