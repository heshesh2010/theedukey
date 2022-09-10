import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/app/modules/home/controllers/home_controller.dart';
import '../../../../elements/drawer.dart';
import '../../../../elements/topbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../core/utils/image_tools.dart';
import '../../../data/models/facility.dart';
import '../../../data/models/route_argument.dart';
import '../../../data/models/stage.dart';
import '../../../data/service/locator.dart';
import '../../../data/service/search_model.dart';
import '../../../routes/app_pages.dart';
import 'about_us.dart';

class HomeView extends GetWidget<HomeController> {
  const HomeView({Key? key}) : super(key: key);

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
                                  const EdgeInsets.only(right: 30.0, left: 30),
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
                            items: controller.stagesList
                                .map((Stage selectedStage) {
                              return DropdownMenuItem(
                                value: selectedStage,
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
                              );
                            }).toList(),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                        autofocus: false,
                        style: DefaultTextStyle.of(context)
                            .style
                            .copyWith(fontStyle: FontStyle.italic),
                        decoration: InputDecoration(
                            hintText: "school_name".tr,
                            border: const OutlineInputBorder())),
                    suggestionsCallback: (pattern) async {
                      controller.pattern = pattern;
                      return await controller.getSuggestions(pattern);
                    },
                    itemBuilder: (context, Facility suggestion) {
                      return ListTile(
                        leading: ImageTools.image(
                          url: suggestion.school?.logo,
                          height: 50,
                          width: 50,
                        ),
                        title: Text(suggestion.school?.name ?? ""),
                        subtitle: Text(suggestion.school?.cityName ?? ""),
                      );
                    },
                    onSuggestionSelected: (Facility suggestion) {
                      Get.toNamed(Routes.schoolDetails,
                          arguments: RouteArgument(
                              schoolId: suggestion.school?.id ?? 0));
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //  shape: const CircleBorder(),
                        shadowColor: Colors.transparent,
                        // padding: const EdgeInsets.all(10),
                        primary: Theme.of(context).primaryColor,
                        onPrimary: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Text(
                        "search".tr,
                      ),
                      onPressed: () {
                        getIt<SearchModel>().search(RouteArgument(stagesList: [
                          controller.selectedStage.value.id ?? -1
                        ], keyword: controller.pattern));

                        Get.toNamed(
                          Routes.search,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const AboutUs()
          ],
        ),
      ),
    );
  }
}
