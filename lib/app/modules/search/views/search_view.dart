import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:theedukey/app/modules/search/views/school_item.dart';
import 'package:theedukey/app/modules/search/views/search_filters.dart';

import '../../../../elements/drawer.dart';
import '../../../../elements/topbar.dart';
import '../../../data/models/route_argument.dart';
import '../../../data/service/locator.dart';
import '../../../data/service/search_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/search_controller.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTopBar(context, title: "search".tr, isback: true),
      drawer: DrawerSideMenu(),
      body: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        'search_results_for'.tr,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                        child: Text(
                          getIt<SearchModel>().routeArgument?.keyword ?? " ",
                          maxLines: 4,
                          textAlign: TextAlign.justify,
                          //  overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.pin_drop),
                    label: Text('show_results_on_map'.tr),
                    onPressed: () {
                      Get.toNamed(Routes.map);
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SearchFilters(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GetX<SearchController>(
                //   init: SearchController(),
                builder: (_) {
                  return _.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : _.schoolList.isEmpty
                          ? Center(child: Text('empty_results'.tr))
                          : ListView.builder(
                              itemCount: _.schoolList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: InkWell(
                                    onTap: () => Get.toNamed(
                                        Routes.schoolDetails,
                                        arguments: RouteArgument(
                                            schoolId: _
                                                .schoolList[index].school?.id)),
                                    child: SchoolItem(
                                      school: _.schoolList[index].school,
                                    ),
                                  ),
                                );
                              },
                            );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
