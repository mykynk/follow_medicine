import 'package:flutter/material.dart';
import 'package:followmedicine/helper/colors.dart';
import 'package:followmedicine/helper/size.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicineWidget extends StatefulWidget {
  MedicineWidget(
      {Key? key,
      required this.medicineName,
      required this.medicineDesc,
      this.count = 0,
      this.completedCount = 1})
      : super(key: key);
  final String medicineName;
  final String medicineDesc;
  final int count;
  final int completedCount;
  @override
  State<MedicineWidget> createState() => _MedicineWidgetState();
}

class _MedicineWidgetState extends State<MedicineWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * 0.9,
      height: 65,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              lightGreen,
              lightGreen,
              lightBlue,
            ],
            stops: [
              0,

              widget.completedCount /
                  widget.count, //* 2 sayısı değişken olacak.
              widget.completedCount / widget.count
            ]),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              widget.medicineName,
              style: GoogleFonts.montserrat(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              widget.medicineDesc,
              style: GoogleFonts.montserrat(height: 1.6, color: grey),
            ),
          ),
        ],
      ),
    );
  }
}
