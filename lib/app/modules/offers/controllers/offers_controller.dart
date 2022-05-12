import 'package:get/get.dart';

import '../../../../helper.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../data/models/offer.dart';
import '../../../data/repositories/offers_repository.dart';

class OffersController extends GetxController {
  var offersList = <OfferData>[].obs;
  final PagingController<int, OfferData> pagingController =
      PagingController(firstPageKey: 0);
  static const _pageOffersSize = 15;
  List<OfferData> newOffersItems = [OfferData()];

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchFavoritePage(pageKey);
    });
    super.onInit();
  }

  Future<void> _fetchFavoritePage(pageKey) async {
    try {
      if (pageKey == 0) {
        newOffersItems = await getOffers();
      } else {
        newOffersItems = await getOffers(nextUrl: nextUrl);
      }

      final isLastPage =
          newOffersItems.length < _pageOffersSize || nextUrl == null;
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
    dynamic response = await getOffersApi(nextUrl: nextUrl);
    if (response is List<OfferData>) {
      offersList.addAll(response);
      return offersList;
    } else {
      Helper().showErrorToast("حدث خطأ بالاتصال حاول لاحقاً");
    }
  }
}
