import '../entities/all_feeding_data_entity.dart';
import '../repositories/feeding_schedule_repository.dart';

class AllFeedingDataUseCase {
  final FeedingScheduleRepository feedingScheduleRepository;

  AllFeedingDataUseCase({required this.feedingScheduleRepository});

  Future<List<AllFeedingDataEntity>> getAllFeedingData() async {
    return await feedingScheduleRepository.getAllFeedingData();
  }
}
