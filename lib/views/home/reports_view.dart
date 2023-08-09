import 'package:attendx/models/attendance_report_model.dart';
import 'package:attendx/services/attendance_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReportsView extends StatefulWidget {
  const ReportsView({super.key});

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        toolbarHeight: 100,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff021D49), Color(0xff023768)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reports",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                  height: 70,
                  width: 70,
                  child: Icon(
                    Icons.refresh,
                    size: 30,
                  )),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: AttendanceService.getUserAttendances(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }else{
            AttendanceReportModel? data = snapshot.data;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: data!.results.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(data.results[index].attendanceType),
                        subtitle: Text(data.results[index].activity),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10
                              ),
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Color(0xff021D49), Color(0xff023768)]),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                              child: Text(
                                  timeago.format(data.results[index].createdAt),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10
                              ),
                              child: Text(
                                DateFormat.yMd().add_jms().format(data.results[index].createdAt),
                                // data.results[index].createdAt.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.grey[500]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        }
      )
    );
  }

}
