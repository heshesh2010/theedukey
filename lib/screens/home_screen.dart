import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/controller/home_controller.dart';
import '../elements/drawer.dart';
import '../elements/topbar.dart';
import '../models/stage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

//  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerSideMenu(),
      appBar: getTopBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //    const TopBar(),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: [
                  Text("search_about".tr,
                      style: Theme.of(context).textTheme.headline4),
                  const SizedBox(height: 20),
                  Obx(() => Center(
                        child: Container(
                          // width: 400,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Theme.of(context).focusColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: DropdownButton2(
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            isExpanded: true,
                            iconSize: 0.0,
                            icon: const Icon(Icons.keyboard_arrow_up_sharp),
                            style: const TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.white,
                            hint: Padding(
                              padding:
                                  const EdgeInsets.only(right: 50.0, left: 50),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      controller.selectedStage.value.name!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onChanged: (dynamic value) {
                              controller.setSelectedStage(value);
                              controller.selectedStage.value = value;
                            },
                            //  value: controller.selectedStage.value!=null?controller.stagesList[0]:null,
                            items: controller.stagesList
                                .map((Stage selectedStage) {
                              return DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 50.0, left: 50),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.keyboard_arrow_up_sharp,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        selectedStage.name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ],
                                  ),
                                ),
                                value: selectedStage,
                              );
                            }).toList(),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
