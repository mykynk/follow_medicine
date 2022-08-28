import 'package:flutter/material.dart';
import 'package:followmedicine/helper/boxNames.dart';
import 'package:followmedicine/helper/size.dart';
import 'package:followmedicine/models/medicine.dart';
import 'package:followmedicine/view/addMedicine.dart';
import 'package:followmedicine/helper/colors.dart';
import 'package:followmedicine/widgets/medicineWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyMedicine extends StatefulWidget {
  MyMedicine({Key? key}) : super(key: key);

  @override
  State<MyMedicine> createState() => _MyMedicineState();
}

class _MyMedicineState extends State<MyMedicine> {
  @override
  initState() {
    Hive.openBox(medicineBox);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My\nMedicines",
                      style: GoogleFonts.montserrat(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    IconButton(
                      iconSize: 32,
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: ValueListenableBuilder(
                    valueListenable: Hive.box(medicineBox).listenable(),
                    builder: (context, Box box, _) {
                      if (box.values.isEmpty) {
                        return SizedBox(
                          height: height(context) * 0.7,
                          child: const Center(
                            child: Text("Medicine list is empty."),
                          ),
                        );
                      }
                      return SizedBox(
                        height: box.values.length * 200,
                        child: ListView.builder(
                          itemCount: box.values.length,
                          itemBuilder: (context, index) {
                            Medicine res = box.getAt(index);
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        editMedicine(res, index);
                                      },
                                      child: MedicineWidget(
                                        medicineName: res.name,
                                        medicineDesc: res.desc,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 65,
                                    width: 65,
                                    margin: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: lightGreen,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                      ),
                                      onPressed: () {
                                        deleteMedicine(context, index);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: lightGreen,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddMedicine(
                pageType: PageType.addMedicine,
              ),
            ),
          ).then((medicine) => medicine != null ? addMedicine(medicine) : {}),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  deleteMedicine(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: 200,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Delete Medicine",
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "All data of this medicine will be deleted.",
                  style: GoogleFonts.montserrat(),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  dialogButton(
                      "Cancel", darkGreen, () => Navigator.pop(context)),
                  dialogButton("Delete", lightGreen, () {
                    var box = Hive.box(medicineBox);
                    box.deleteAt(index);
                    Navigator.pop(context);
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton dialogButton(
      String text, Color backgroundColor, Function onPressed) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor)),
      onPressed: () {
        onPressed();
      },
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  editMedicine(Medicine medicine, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddMedicine(
          medicine: medicine,
          pageType: PageType.editMedicine,
        ),
        fullscreenDialog: true,
      ),
    ).then(
      (medicine) {
        if (medicine != null) {
          var box = Hive.box(medicineBox);
          box.putAt(index, medicine);
        }
      },
    );
  }

  addMedicine(Medicine medicine) {
    var box = Hive.box(medicineBox);
    box.add(medicine);
  }
}
