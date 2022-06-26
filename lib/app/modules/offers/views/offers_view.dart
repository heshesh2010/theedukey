import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../elements/empty_results.dart';
import '../../../../elements/no_other_results.dart';
import '../../../../elements/drawer.dart';
import 'offer_item.dart';
import '../../../../elements/topbar.dart';
import '../../../data/models/offer.dart';
import '../controllers/offers_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/utils/first_page_error_indicator.dart';

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
        child: GetBuilder<OffersController>(
          builder: (c) => PagedListView<int, OfferData>.separated(
            scrollDirection: Axis.vertical,
            pagingController: controller().pagingController,
            builderDelegate: PagedChildBuilderDelegate<OfferData>(
              itemBuilder: (context, item, index) => GestureDetector(
                child: OfferItem(
                  offer: item,
                ),
              ),
              //  firstPageProgressIndicatorBuilder: (_)=> ShimmerHelper(type: Type.complex),
              noItemsFoundIndicatorBuilder: (_) => const EmptyResults(),
              firstPageErrorIndicatorBuilder: (_) => FirstPageErrorIndicator(
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
