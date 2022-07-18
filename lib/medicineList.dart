import 'package:flutter/material.dart';
import 'package:followmedicine/colors.dart';
import 'package:followmedicine/drinkDates.dart';
import 'package:followmedicine/medicine.dart';
import 'package:followmedicine/medicineWidget.dart';
import 'package:followmedicine/size.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MedicineList extends StatefulWidget {
  MedicineList({Key? key}) : super(key: key);

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
                DrinkDates item = drinkDates.where((item) => item.date == "18/07/2022").toList()[0];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: MedicineWidget(
                    medicineName: res.name,
                    medicineDesc: res.desc,
                    count: res.count,
                    completedCount: item.completedCount,
                  ),
                );
              },
            ),
          );
        });
  }
}
