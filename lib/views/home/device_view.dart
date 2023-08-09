import 'package:attendx/views/home/device_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendx/controllers/blue_controller.dart';

class DeviceView extends StatefulWidget {
  final String option;

  const DeviceView({super.key, required this.option});

  @override
  State<DeviceView> createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  @override
  Widget build(BuildContext context) {
    final BluetoothController controller = Get.put(BluetoothController());
    return Obx(() {
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
                      widget.option,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                    Text(
                      "Available Devices",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    )
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
        body: controller.devicesList.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(child: Text("No Devices Found!")),
                ],
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.devicesList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: (){
                        Get.to(() => DeviceDetailsView(
                          deviceName: controller.devicesList[index].name,
                          deviceAddr: controller.devicesList[index].address,
                          option: widget.option,
                        ));
                      },
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(controller.devicesList[index].name),
                          subtitle: Text(controller.devicesList[index].address),
                          trailing: Container(
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
                              "SELECT",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
      );
    });
  }
}
