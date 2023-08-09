import 'package:attendx/services/attendance_service.dart';
import 'package:attendx/views/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceDetailsView extends StatefulWidget {
  final String deviceName;
  final String deviceAddr;
  final String option;
  const DeviceDetailsView({super.key, required this.option, required this.deviceName, required this.deviceAddr});

  @override
  State<DeviceDetailsView> createState() => _DeviceDetailsViewState();
}

class _DeviceDetailsViewState extends State<DeviceDetailsView> {
  final TextEditingController _activityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        toolbarHeight: 120,
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
                    widget.option,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 14),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    widget.deviceName,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  Text(
                    widget.deviceAddr,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 17),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          TextFieldWidget(
            child: TextFormField(
              controller: _activityController,
              style: const TextStyle(fontSize: 17),
              cursorColor: Color(0xff021D49),
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.numbers,
                  color: Color(0xff021D49),
                ),
                hintText: "Enter Activity (*Optional)",
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              _confirmDialog();
            },
            child: Container(
              height: 45,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                "Submit",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.yellow,
                    fontWeight: FontWeight.w400,
                    fontSize: 17),
              ),
              decoration: BoxDecoration(
                  color: Color(0xff021D49),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      )
    );
  }

  void _confirmDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(builder: (context) {
                var height = 50.0;
                var width = MediaQuery.of(context).size.width * 0.8;

                return Container(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Are You Sure You Want Submit?.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xff021D49)),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "NO",
                              style: TextStyle(
                                  fontSize: 17, color: Color(0xff021D49)),
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.of(context).pop();
                          _submitData();
                        },
                        child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xff021D49),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text("YES",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ))),
                      ),
                    )
                  ],
                )
              ],
            );
          });
        });
  }

  void _submitData() async{
    _showLoadingDialog();

    bool res = await AttendanceService.addAttendance(
        device_name: widget.deviceName,
        device_addr: widget.deviceAddr,
        attendance_type: widget.option,
        activity: _activityController.text.trim());

    Get.back();

    // print("Res " +res.toString());

    if(res == false){
      _showFailureDialog();
    }else{
      _showSuccessDialog();
    }
  }

  _showLoadingDialog() async {
    Get.defaultDialog(
        title: "",
        barrierDismissible: false,
        content: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    strokeWidth: 2,
                  )
                ],
              ),
            ],
          ),
        ));
  }

  _showFailureDialog() async {
    Get.defaultDialog(
        title: "",
        barrierDismissible: false,
        content: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cancel_outlined,
                color: Colors.red[900],
                size: 40,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Sorry",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.red[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Failed to Record Attendance!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
    await Future.delayed(Duration(seconds: 5));
    Get.back();
  }

  _showSuccessDialog() async {
    Get.defaultDialog(
        title: "",
        content: Container(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_box,
                color: Theme.of(context).primaryColor,
                size: 40,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Alert",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Successfully Recorded Attendance",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    strokeWidth: 2,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
    await Future.delayed(Duration(seconds: 3));
    Get.back();
    Get.back();
  }

}
