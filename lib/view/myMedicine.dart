import 'package:flutter/material.dart';
import 'package:followmedicine/models/medicine.dart';
import 'package:followmedicine/view/addMedicine.dart';
import 'package:followmedicine/helper/colors.dart';
import 'package:followmedicine/widgets/medicineWidget.dart';
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
    Hive.openBox('medicines');
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: ValueListenableBuilder(
            valueListenable: Hive.box('medicines').listenable(),
            builder: (context, Box box, _) {
              if (box.values.isEmpty) {
                return const Center(
                  child: Text("Todo list is empty"),
                );
              }
              return ListView.builder(
                itemCount: box.values.length,
                itemBuilder: (context, index) {
                  Medicine res = box.getAt(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: MedicineWidget(
                            medicineName: res.name,
                            medicineDesc: res.desc,
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
                            icon: const Icon(Icons.delete),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }),
      ),
      floatingActionButton: IconButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AddMedicine(),
              fullscreenDialog: true),
        ).then((value) => addMedicine(value)),
        icon: const Icon(Icons.add),
      ),
    );
  }

  deleteMedicine(int index) {
    var box = Hive.box('medicines');

    box.deleteAt(index);
  }

  editMedicine(Medicine medicine, int index) {
    var box = Hive.box('medicines');
    box.put(index, medicine);
  }

  addMedicine(Medicine medicine) {
    var box = Hive.box('medicines');

    box.add(medicine);
  }
}
