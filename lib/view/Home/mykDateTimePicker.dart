import 'package:flutter/material.dart';
import 'package:followmedicine/helper/colors.dart';
import 'package:followmedicine/helper/dateList.dart';
import 'package:followmedicine/view/Home/hiveProvider.dart';
import 'package:followmedicine/view/Home/medicineList.dart';
import 'package:followmedicine/helper/size.dart';
import 'package:followmedicine/view/Home/monthBar.dart';
import 'package:provider/provider.dart';

class MykDateTimePicker extends StatefulWidget {
  const MykDateTimePicker({Key? key}) : super(key: key);

  @override
  State<MykDateTimePicker> createState() => _MykDateTimePickerState();
}

class _MykDateTimePickerState extends State<MykDateTimePicker> {
  String selectedDate = DateTime.now().toString();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            MonthBar(),
            ChangeNotifierProvider(
              create: (context) => HiveProvider(),
              child: MedicineList(
                date: selectedDate,
              ),
            )
          ],
        ),
      ),
    );
  }
}
