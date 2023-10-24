import '../entities/feeding_schedule_entity.dart';
import '../repositories/feeding_schedule_repository.dart';

class FeedingScheduleUseCase {
  final FeedingScheduleRepository feedingScheduleRepository;

  FeedingScheduleUseCase({required this.feedingScheduleRepository});

  Future<FeedingScheduleEntity> createFeedingSchedule({
    required DateTime startDate,
    required DateTime endDate,
    required int amount,
    required int chickens,
    required String recurrence,
  }) async {
    try {
      // Call the feedingScheduleRepository method to create feeding schedule
      final result = await feedingScheduleRepository.createFeedingSchedule(
        startDate: startDate,
        endDate: endDate,
        amount: amount,
        chickens: chickens,
        recurrence: recurrence,
      );

      // Return the entity representing the successful message
      return result;
    } catch (e) {
      print(e.toString());
      // Handle any errors and return an entity representing the failure
      return FeedingScheduleEntity(
          message: "Failed to create feeding schedule");
    }
  }

  Future<FeedingScheduleEntity> updateFeedingSchedule({
    required DateTime previousDate,
    required DateTime startDate,
    required DateTime endDate,
    required int amount,
    required int chickens,
    required String recurrence,
  }) async {
    try {
      // Call the feedingScheduleRepository method to create feeding schedule
      final result = await feedingScheduleRepository.updateFeedingSchedule(
        previousDate: previousDate,
        startDate: startDate,
        endDate: endDate,
        amount: amount,
        chickens: chickens,
        recurrence: recurrence,
      );

      // Return the entity representing the successful message
      return result;
    } catch (e) {
      print(e.toString());
      // Handle any errors and return an entity representing the failure
      return FeedingScheduleEntity(
          message: "Failed to update feeding schedule");
    }
  }

  Future<FeedingScheduleEntity> deleteFeedingSchedule({
    required DateTime startDate,
  }) async {
    try {
      // Call the feedingScheduleRepository method to create feeding schedule
      final result = await feedingScheduleRepository.deleteFeedingSchedule(
        startDate: startDate,
      );

      // Return the entity representing the successful message
      return result;
    } catch (e) {
      print(e.toString());
      // Handle any errors and return an entity representing the failure
      return FeedingScheduleEntity(message: e.toString());
    }
  }
}
