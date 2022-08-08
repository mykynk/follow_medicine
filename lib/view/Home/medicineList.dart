import 'package:flutter/material.dart';
import 'package:followmedicine/helper/boxNames.dart';
import 'package:followmedicine/helper/colors.dart';
import 'package:followmedicine/helper/dateList.dart';
import 'package:followmedicine/models/drinkDates.dart';
import 'package:followmedicine/models/medicine.dart';
import 'package:followmedicine/view/Home/hiveProvider.dart';
import 'package:followmedicine/view/Home/monthBar.dart';
import 'package:followmedicine/widgets/medicineWidget.dart';
import 'package:followmedicine/helper/size.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

class MedicineList extends StatefulWidget {
  MedicineList({Key? key, required this.date}) : super(key: key);
  final String date;
  @override
  State<MedicineList> createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  bool isBoxOpen = false;

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      context
          .watch<HiveProvider>()
          .isBoxOpen(medicineBox)
          .then((value) => isBoxOpen = value);
    }
    return isBoxOpen
        ? ValueListenableBuilder(
            valueListenable: Hive.box(medicineBox).listenable(),
            builder: (context, Box box, _) {
              if (box.values.isEmpty) {
                return const Center(
                  child: Text("Medicine list is empty"),
                );
              }
              return SizedBox(
                height: box.values.length * 200,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    Medicine res = box.getAt(index);
                    if (res.selectedDays.contains(days[selectedIndex % 7])) {
                      List<DrinkDates> drinkDates = res.drinkDates;
                      DrinkDates item = drinkDates.firstWhere(
                        
                        (item) => item.date == "$selectedIndex/${tabController.index+1}/2022",
                        orElse: () => DrinkDates()..completedCount = 0,
                      );
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: MedicineWidget(
                                medicineName: res.name,
                                medicineDesc: res.desc,
                                count: res.count,
                                completedCount:
                                    item == null ? 0 : item.completedCount,
                              ),
                            ),
                            IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  int replaceIndex = drinkDates.indexOf(item);
                                  if (replaceIndex == -1) {
                                    drinkDates.add(
                                      DrinkDates()
                                        ..date = "$selectedIndex/${tabController.index+1}/2022"
                                        ..completedCount = 1,
                                    );
                                  } else {
                                    if (item.completedCount < res.count) {
                                      item.completedCount++;
                                    }
                                    drinkDates[replaceIndex] = item;
                                  }

                                  box.putAt(
                                      index, res..drinkDates = drinkDates);
                                }),
                            IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  int replaceIndex = drinkDates.indexOf(item);
                                  if (replaceIndex == -1) {
                                    drinkDates.remove(
                                      DrinkDates()
                                        ..date = "$selectedIndex/${tabController.index+1}/2022"
                                        ..completedCount = 1,
                                    );
                                  } else {
                                    if (item.completedCount > 0) {
                                      item.completedCount--;
                                    }
                                    drinkDates[replaceIndex] = item;
                                  }

                                  box.putAt(
                                      index, res..drinkDates = drinkDates);
                                })
                          ],
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              );
            })
        : const CircularProgressIndicator();
  }
}
