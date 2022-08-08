import 'package:flutter/material.dart';
import 'package:followmedicine/helper/colors.dart';
import 'package:followmedicine/helper/dateList.dart';
import 'package:followmedicine/helper/size.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class MonthBar extends StatefulWidget {
  MonthBar({Key? key}) : super(key: key);

  @override
  State<MonthBar> createState() => _MonthBarState();
}

late int selectedIndex;
late TabController tabController;
class _MonthBarState extends State<MonthBar> with TickerProviderStateMixin {
  
  late int weekday = DateTime(2022, DateTime.now().month).weekday;

 
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: month.length, vsync: this);
    tabController.index = DateTime.now().month - 1;
    weekday = DateTime(2022, DateTime.now().month).weekday;
    selectedIndex = (DateTime.now().day - 1) + weekday;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          labelColor: Colors.black,
          labelStyle: GoogleFonts.montserrat(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: GoogleFonts.montserrat(
            color: grey,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          indicator: const BoxDecoration(),
          padding: const EdgeInsets.all(8),
          controller: tabController,
          tabs: List.generate(
            month.length,
            (index) => Tab(
              text: month[index],
            ),
          ),

        ),
        Container(
          width: width(context),
          margin: const EdgeInsets.only(top: 16),
          height: 40,
          child: GridView.count(
            padding: const EdgeInsets.only(top: 10),
            crossAxisCount: 7,
            children: List.generate(
              days.length,
              (index) => SizedBox(
                width: width(context) * 0.12,
                child: Text(
                  days[index].substring(0, 3),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(color: grey),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: width(context) * 0.9,
          width: width(context),
          child: TabBarView(
              controller: tabController,
              children: List.generate(month.length, (tabBarIndex) {
                int currentMonthDayCount = DateTime.utc(
                  2022,
                  tabBarIndex + 2,
                ).subtract(const Duration(days: 1)).day;
                weekday = DateTime(2022, tabBarIndex + 1).weekday;
                return Column(
                  children: [
                    // Text(weekday.toString()),
                    Expanded(
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 10),
                        crossAxisCount: 7,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 8.0,
                        children: List.generate(
                          weekday + currentMonthDayCount,
                          (index) => index >= weekday
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 500),
                                    width: width(context) * 0.12,
                                    margin: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: index == selectedIndex 
                                          ? lightGreen
                                          : lightBlue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        (index + 1 - weekday).toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                  ],
                );
              })),
        ),
      ],
    );
  }
}
