import 'package:attendx/views/home/device_view.dart';
import 'package:attendx/views/home/reports_view.dart';
import 'package:attendx/views/home/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double appBarHeight = 200;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - appBarHeight) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        toolbarHeight: 200,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff021D49), Color(0xff023768)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.add_card_sharp)),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ATTEND KCU",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 15),
                ),
                Text(
                  "Attendance Monitor",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                )
              ],
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Expanded(
                child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / itemHeight)),
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const DeviceView(option: "CHECK IN"));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color(0xff021D49)!,
                                  border: Border.all(
                                    color: Colors.blue[800]!,
                                  ),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Icon(
                                Icons.lock_clock,
                                size: 50,
                                color: Colors.white,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Check In",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                    fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const DeviceView(option: "CHECK OUT"));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color(0xff870101)!,
                                  border: Border.all(
                                    color: Colors.red[800]!,
                                  ),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Icon(
                                Icons.punch_clock,
                                size: 50,
                                color: Colors.white,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Check Out",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                    fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    Get.to(() => const SettingsView());
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color(0xff16372A),
                                  border: Border.all(
                                    color: Colors.green[800]!,
                                  ),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Icon(
                                Icons.settings,
                                size: 50,
                                color: Colors.white,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Settings",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                    fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(() => const ReportsView());
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color(0xffF7B801),
                                  border: Border.all(
                                    color: Colors.yellow[800]!,
                                  ),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Icon(
                                Icons.report,
                                size: 50,
                                color: Colors.white,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Reports",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                    fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
