import 'package:flutter/material.dart';
import 'package:followmedicine/helper/colors.dart';
import 'package:flutter/services.dart';
import 'package:followmedicine/helper/dateList.dart';
import 'package:followmedicine/models/drinkDates.dart';
import 'package:followmedicine/models/medicine.dart';

import 'package:google_fonts/google_fonts.dart';

enum PageType { addMedicine, editMedicine }

class AddMedicine extends StatefulWidget {
  const AddMedicine({
    Key? key,
    this.medicine,
    required this.pageType,
  }) : super(key: key);
  final Medicine? medicine;
  final PageType pageType;
  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final GlobalKey _formKey = GlobalKey();
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _countController;
  List selectedDays = [];
  List<DrinkDates> drinkDates = [];

  @override
  void initState() {
    _nameController = TextEditingController(
      text:
          widget.pageType == PageType.editMedicine ? widget.medicine!.name : "",
    );
    _descController = TextEditingController(
      text:
          widget.pageType == PageType.editMedicine ? widget.medicine!.desc : "",
    );
    _countController = TextEditingController(
      text: widget.pageType == PageType.editMedicine
          ? widget.medicine!.count.toString()
          : "",
    );
    if (widget.pageType == PageType.editMedicine) {
      days.forEach((element) {
        if (!selectedDays.contains(element)) {
          selectedDays.add(element);
        }
      });
      drinkDates = widget.medicine!.drinkDates ;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: darkGreen,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _form(),
        ),
      ),
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          labelText("Name"),
          TextFormField(
            controller: _nameController,
            cursorColor: lightGreen,
            decoration: _inputDecoration(),
          ),
          const SizedBox(
            height: 20,
          ),
          labelText("Description"),
          TextFormField(
            controller: _descController,
            cursorColor: lightGreen,
            decoration: _inputDecoration(),
          ),
          const SizedBox(
            height: 20,
          ),
          labelText("Count"),
          TextFormField(
            controller: _countController,
            cursorColor: lightGreen,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: _inputDecoration(),
          ),
          const SizedBox(
            height: 20,
          ),
          labelText("Select Days"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: selectDays(),
          ),
          TextButton(
            onPressed: () => setState(() {
              days.forEach((element) {
                if (!selectedDays.contains(element)) {
                  selectedDays.add(element);
                }
              });
            }),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Select All Days",
                style: GoogleFonts.montserrat(
                    color: lightGreen, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                backgroundColor: MaterialStateProperty.all(darkGreen),
              ),
              onPressed: () => Navigator.pop(
                context,
                Medicine()
                  ..name = _nameController.text
                  ..desc = _descController.text
                  ..count = int.parse(_countController.text)
                  ..selectedDays = selectedDays
                  ..drinkDates = drinkDates,
              ),
              child: Text(
                widget.pageType == PageType.addMedicine
                    ? "Add Medicine"
                    : "Edit Medicine",
                style: GoogleFonts.montserrat(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: lightGreen, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      filled: true,
      fillColor: lightBlue,
      focusColor: Colors.white,
    );
  }

  labelText(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }

  List<Widget> selectDays() {
    return List.generate(days.length, (index) {
      return GestureDetector(
        onTap: () => setState(() {
          if (selectedDays.contains(days[index])) {
            selectedDays.remove(days[index]);
          } else {
            selectedDays.add(days[index]);
          }
        }),
        child: Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.all(4.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedDays.contains(days[index]) ? lightGreen : lightBlue,
          ),
          child: Text(
            days[index].substring(0, 1),
          ),
        ),
      );
    });
  }
}
