import 'package:followmedicine/models/drinkDates.dart';
import 'package:hive/hive.dart';
part 'medicine.g.dart';

@HiveType(typeId: 0)
class Medicine extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String desc;

  @HiveField(2)
  late int count;

  @HiveField(3)
  late List<DrinkDates> drinkDates;
}
