import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../core/utils/FirstPageErrorIndicator.dart';
import '../../../../core/utils/local_storage.dart';
import '../../../../elements/PermissionDeniedWidget.dart';
import '../../../../elements/drawer.dart';
import '../../../../elements/favorite_item.dart';
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
                builder: (_c) => PagedListView<int, Favorite>.separated(
                  scrollDirection: Axis.vertical,
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Favorite>(
                    itemBuilder: (context, item, index) => GestureDetector(
                      child: FavoriteItem(
                        favorite: item,
                      ),
                    ),
                    //  firstPageProgressIndicatorBuilder: (_)=> ShimmerHelper(type: Type.complex),
                    //     noItemsFoundIndicatorBuilder: (_)=> EmptyOrdersWidget(),
                    firstPageErrorIndicatorBuilder: (_) =>
                        FirstPageErrorIndicator(
                      error: controller.pagingController.error,
                      onTryAgain: () => controller.pagingController.refresh(),
                    ),
                    newPageErrorIndicatorBuilder: (_) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: ElevatedButton(
                          onPressed: null,
                          child: Text("no_other_favorite".tr),
                        ),
                      ),
                    ),
                    noMoreItemsIndicatorBuilder: (_) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: ElevatedButton(
                          onPressed: null,
                          child: Text("no_other_favorite".tr),
                        ),
                      ),
                    ),
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
