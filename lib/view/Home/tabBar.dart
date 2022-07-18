import 'package:flutter/material.dart';
import 'package:followmedicine/helper/colors.dart';
import 'package:followmedicine/helper/dateList.dart';
import 'package:followmedicine/helper/size.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class TabBarWidget extends StatefulWidget {
  TabBarWidget({Key? key}) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

late int selectedIndex;

class _TabBarWidgetState extends State<TabBarWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late int weekday = DateTime(2022, DateTime.now().month).weekday;

  get selectedTabBar => _tabController.index;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: month.length, vsync: this);
    _tabController.index = DateTime.now().month - 1;
    weekday = DateTime(2022, DateTime.now().month).weekday;
    selectedIndex = (DateTime.now().day - 1) + weekday;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(DateTime.now().day.toString());
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
          controller: _tabController,
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
                  days[index],
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
              controller: _tabController,
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
                                      debugPrint((index - weekday).toString());
                                      selectedIndex = index;
                                    });
                                  },
                                  child: Container(
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
