import 'package:hive/hive.dart';
part 'drinkDates.g.dart';

@HiveType(typeId: 1)
class DrinkDates extends HiveObject {
  @HiveField(0)
  late String date;

  @HiveField(1)
  late int completedCount;
}
