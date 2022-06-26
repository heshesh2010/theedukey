import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../elements/empty_results.dart';
import '../../../../elements/no_other_results.dart';
import '../../../core/utils/first_page_error_indicator.dart';
import '../../../core/utils/local_storage.dart';
import '../../../../elements/permission_dcenied_widget.dart';
import '../../../../elements/drawer.dart';
import 'favorite_item.dart';
import '../../../../elements/topbar.dart';
import '../../../data/models/favorite.dart';
import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTopBar(context, title: 'favorite'.tr),
      drawer: const DrawerSideMenu(),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10.0, top: 10, bottom: 15),
        child: LocalStorage().getUser()?.token == null
            ? const PermissionDeniedWidget()
            : GetBuilder<FavoriteController>(
                builder: (c) => PagedListView<int, FavoriteDataData>.separated(
                  scrollDirection: Axis.vertical,
                  pagingController: controller().pagingController,
                  builderDelegate: PagedChildBuilderDelegate<FavoriteDataData>(
                    itemBuilder: (context, item, index) => GestureDetector(
                      child: FavoriteItem(
                        favorite: item,
                      ),
                    ),
                    //  firstPageProgressIndicatorBuilder: (_)=> ShimmerHelper(type: Type.complex),
                    noItemsFoundIndicatorBuilder: (_) => const EmptyResults(),
                    firstPageErrorIndicatorBuilder: (_) =>
                        FirstPageErrorIndicator(
                      error: controller().pagingController.error,
                      onTryAgain: () => controller().pagingController.refresh(),
                    ),
                    newPageErrorIndicatorBuilder: (_) =>
                        FirstPageErrorIndicator(
                      error: controller().pagingController.error,
                      onTryAgain: () => controller().pagingController.refresh(),
                    ),
                    noMoreItemsIndicatorBuilder: (_) => const NoOtherResults(),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                ),
              ),
      ),
    );
  }
}