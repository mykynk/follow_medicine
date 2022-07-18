import 'package:flutter/material.dart';
import 'package:followmedicine/helper/colors.dart';
import 'package:followmedicine/models/drinkDates.dart';
import 'package:followmedicine/models/medicine.dart';
import 'package:followmedicine/view/Home/tabBar.dart';
import 'package:followmedicine/widgets/medicineWidget.dart';
import 'package:followmedicine/helper/size.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MedicineList extends StatefulWidget {
  MedicineList({Key? key, required this.date}) : super(key: key);
  final String date;
  @override
  State<MedicineList> createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('medicines').listenable(),
        builder: (context, Box box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text("Medicine list is empty"),
            );
          }
          return Container(
            height: box.values.length * 200,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Medicine res = box.getAt(index);
                List<DrinkDates> drinkDates = res.drinkDates;
                List<DrinkDates> items = drinkDates
                    .where((item) => item.date == "$selectedIndex/$selectedTabBar/2022")
                    .toList();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: MedicineWidget(
                    medicineName: res.name,
                    medicineDesc: res.desc,
                    count: res.count,
                    completedCount:
                        items.length > 0 ? items.first.completedCount : 0,
                  ),
                );
              },
            ),
          );
        });
  }
}
