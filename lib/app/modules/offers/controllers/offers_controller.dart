import 'package:get/get.dart';

import '../../../../constants/general.dart';
import '../../../../helper.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../data/models/offer.dart';
import '../../../data/repositories/offers_repository.dart';

class OffersController extends GetxController {
  final OffersRepository repository;
  OffersController({required this.repository});

  var offersList = <OfferData?>[].obs;
  final PagingController<int, OfferData?> pagingController =
      PagingController(firstPageKey: 0);
  List<OfferData?> newOffersItems = [OfferData()];

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      newOffersItems.clear();
      offersList.clear();
      _fetchOffersPage(pageKey);
    });
    super.onInit();
  }

  Future<void> _fetchOffersPage(pageKey) async {
    try {
      if (pageKey == 0) {
        newOffersItems = await getOffers();
      } else {
        newOffersItems = await getOffers(nextUrl: repository.nextUrl);
      }

      final isLastPage =
          newOffersItems.length < apiPageSize || repository.nextUrl == null;
      if (isLastPage) {
        pagingController.appendLastPage(newOffersItems);
      } else {
        final nextPageKey = pageKey + newOffersItems.length;
        pagingController.appendPage(newOffersItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<dynamic> getOffers({nextUrl}) async {
    dynamic response =
        await repository.getOffersApi(nextUrl: repository.nextUrl);
    if (response is List<OfferData?>) {
      offersList.addAll(response);
      return offersList;
    } else {
      Helper().showErrorToast("Something went wrong".tr);
    }
  }
}
