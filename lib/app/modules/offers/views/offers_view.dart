import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/local_storage.dart';
import '../../../../elements/PermissionDeniedWidget.dart';
import '../../../../elements/drawer.dart';
import '../../../../elements/offer_item.dart';
import '../../../../elements/topbar.dart';
import '../../../data/models/offer.dart';
import '../controllers/offers_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../core/utils/FirstPageErrorIndicator.dart';

class OffersView extends GetView<OffersController> {
  const OffersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTopBar(context, title: "offers".tr),
      drawer: const DrawerSideMenu(),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10.0, top: 10, bottom: 15),
        child: LocalStorage().getUser()?.token == null
            ? const PermissionDeniedWidget()
            : GetBuilder<OffersController>(
                builder: (_c) => PagedListView<int, OfferData>.separated(
                  scrollDirection: Axis.vertical,
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<OfferData>(
                    itemBuilder: (context, item, index) => GestureDetector(
                      child: OfferItem(
                        offer: item,
                      ),
                    ),
                    //  firstPageProgressIndicatorBuilder: (_)=> ShimmerHelper(type: Type.complex),
                    //     noItemsFoundIndicatorBuilder: (_)=> EmptyOrdersWidget(),
                    firstPageErrorIndicatorBuilder: (_) =>
                        FirstPageErrorIndicator(
                      error: controller.pagingController.error,
                      onTryAgain: () => controller.pagingController.refresh(),
                    ),
                    noMoreItemsIndicatorBuilder: (_) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: ElevatedButton(
                          onPressed: null,
                          child: Text("no_other_offers".tr),
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
