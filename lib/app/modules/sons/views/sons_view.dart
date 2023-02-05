import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../elements/empty_results.dart';
import '../../../../elements/no_other_results.dart';
import '../../../core/utils/first_page_error_indicator.dart';
import '../../../../elements/permission_dcenied_widget.dart';
import '../../../../elements/drawer.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';
import '../controllers/sons_controller.dart';
import 'image_picker/image_picker_helper.dart';
import 'son_item.dart';
import '../../../../elements/topbar.dart';
import '../../../data/models/son.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SonsView extends GetWidget<SonsController> {
  const SonsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getTopBar(context, title: "sons".tr),
        drawer: DrawerSideMenu(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.isFamilyIdExits()
                ? Get.toNamed(Routes.addSon)
                : Get.defaultDialog(
                    title: "certificate_image".tr,
                    content: ImagePickerHelper(
                      editButtonTitle: "edit_family_id_image".tr,
                      buttonTitle: "family_id_image".tr,
                      imageUrl: controller.selectedFamilyIdImage.value,
                      onGet: (value) {
                        controller.onSelectFamilyIdImage(value);
                      },
                    ),
                  );
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10.0, top: 10, bottom: 15),
          child: !Get.find<AuthService>().isAuth
              ? const PermissionDeniedWidget()
              : GetBuilder<SonsController>(
                  builder: (c) => RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () => controller.pagingController.refresh(),
                    ),
                    child: PagedListView<int, SonDataData>.separated(
                      scrollDirection: Axis.vertical,
                      pagingController: controller.pagingController,
                      builderDelegate: PagedChildBuilderDelegate<SonDataData>(
                        itemBuilder: (context, item, index) => GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SonItem(
                              son: item,
                            ),
                          ),
                        ),

                        //  firstPageProgressIndicatorBuilder: (_)=> ShimmerHelper(type: Type.complex),
                        noItemsFoundIndicatorBuilder: (_) =>
                            const EmptyResults(),
                        firstPageErrorIndicatorBuilder: (_) =>
                            FirstPageErrorIndicator(
                          error: controller.pagingController.error,
                          onTryAgain: () =>
                              controller.pagingController.refresh(),
                        ),
                        noMoreItemsIndicatorBuilder: (_) =>
                            const NoOtherResults(),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                    ),
                  ),
                ),
        ));
  }
}
