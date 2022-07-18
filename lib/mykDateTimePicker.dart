import 'package:flutter/material.dart';
import 'package:followmedicine/colors.dart';
import 'package:followmedicine/dateList.dart';
import 'package:followmedicine/medicineList.dart';
import 'package:followmedicine/size.dart';
import 'package:followmedicine/tabBar.dart';

class MykDateTimePicker extends StatefulWidget {
  const MykDateTimePicker({Key? key}) : super(key: key);

  @override
  State<MykDateTimePicker> createState() => _MykDateTimePickerState();
}

class _MykDateTimePickerState extends State<MykDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),

      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TabBarWidget(),
            // Text(
            //   days[DateTime(2022, 7).weekday + 1],
            // ),
            // Text(
            //   DateTime.utc(DateTime.now().year, DateTime.now().month, 1)
            //       .toString(),
            // ),
            // Text(
            //   DateTime.utc(
            //     DateTime.now().year,
            //     DateTime.now().month + 1,
            //   ).subtract(Duration(days: 1)).toString(),
            // ),
            MedicineList()
          ],
        ),
      ),
    );
  }
}
