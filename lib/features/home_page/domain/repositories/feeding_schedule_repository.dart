import 'package:chicken_feeder/features/home_page/domain/entities/feeding_schedule_entity.dart';
import '../entities/all_feeding_data_entity.dart';

abstract class FeedingScheduleRepository {
  Future<FeedingScheduleEntity> createFeedingSchedule({
    required DateTime startDate,
    required DateTime endDate,
    required int amount,
    required int chickens,
    required String recurrence,
  });

  Future<FeedingScheduleEntity> updateFeedingSchedule({
    required DateTime previousDate,
    required DateTime startDate,
    required DateTime endDate,
    required int amount,
    required int chickens,
    required String recurrence,
  });

  Future<FeedingScheduleEntity> deleteFeedingSchedule({
    required DateTime startDate,
  });

  Future<List<AllFeedingDataEntity>> getAllFeedingData();
}
