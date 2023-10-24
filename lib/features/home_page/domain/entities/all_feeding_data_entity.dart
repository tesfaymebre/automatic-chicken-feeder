import '../../data/models/all_feeding_data_model.dart';

class AllFeedingDataEntity {
  final String id;
  final String user;
  final String device;
  final int amount;
  final int chickens;
  final DateTime startDate;
  final DateTime endDate;
  final String recurrence;
  final DateTime createdAt;
  final DateTime updatedAt;

  AllFeedingDataEntity({
    required this.id,
    required this.user,
    required this.device,
    required this.amount,
    required this.chickens,
    required this.startDate,
    required this.endDate,
    required this.recurrence,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AllFeedingDataEntity.fromData(Data data) {
    return AllFeedingDataEntity(
      id: data.sId!,
      user: data.user!,
      device: data.device!,
      amount: data.amount!,
      chickens: data.chickens!,
      startDate: DateTime.parse(data.startDate!),
      endDate: DateTime.parse(data.endDate!),
      recurrence: data.recurrence!,
      createdAt: DateTime.parse(data.createdAt!),
      updatedAt: DateTime.parse(data.updatedAt!),
    );
  }
}
