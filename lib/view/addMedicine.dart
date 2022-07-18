import 'package:flutter/material.dart';
import 'package:followmedicine/helper/colors.dart';
import 'package:flutter/services.dart';
import 'package:followmedicine/models/medicine.dart';

import 'package:google_fonts/google_fonts.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({
    Key? key,
  }) : super(key: key);

  //TODO medicine gelecek buraya
  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final GlobalKey _formKey = GlobalKey();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _countController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
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
                labelText("Desc"),
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
                        ..drinkDates = [],
                    ),
                    child: Text(
                      "Add Medicine",
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
}
