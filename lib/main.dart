import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:followmedicine/helper/boxNames.dart';
import 'package:followmedicine/helper/colors.dart';
import 'package:followmedicine/models/drinkDates.dart';
import 'package:followmedicine/models/medicine.dart';
import 'package:followmedicine/view/myMedicine.dart';
import 'package:followmedicine/view/Home/mykDateTimePicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  const SystemUiOverlayStyle(systemNavigationBarColor: Colors.black);
  await Hive.initFlutter();
  Hive
    ..registerAdapter(MedicineAdapter())
    ..registerAdapter(DrinkDatesAdapter());

  await Hive.openBox(medicineBox);

  runApp(const MedicineApp());
}

class MedicineApp extends StatelessWidget {
  const MedicineApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Follow Medicine',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        primaryColor: lightBlue,
        focusColor: lightBlue,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Follow\nMedicine",
                      style: GoogleFonts.montserrat(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyMedicine(),
                        ),
                      ),
                      iconSize: 46,
                      icon: const Icon(
                        Icons.person,
                     
                      ),
                    ),
                  ],
                ),
              ),
              const MykDateTimePicker(),
            ],
          ),
        ),
      ),
    );
  }
}
