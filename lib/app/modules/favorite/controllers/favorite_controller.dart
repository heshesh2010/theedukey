import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../constants/general.dart';
import '../../../../helper.dart';
import '../../../data/models/favorite.dart';
import '../../../data/repositories/favorite_repository.dart';

class FavoriteController extends GetxController {
  final FavoriteRepository repository;
  FavoriteController({required this.repository});

  final PagingController<int, FavoriteDataData> pagingController =
      PagingController(firstPageKey: 0);
  List<FavoriteDataData> newFavoritItems = [FavoriteDataData()];

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      newFavoritItems.clear();
      _fetchFavoritePage(pageKey);
    });
    super.onInit();
  }

  Future<void> _fetchFavoritePage(pageKey) async {
    try {
      newFavoritItems = await getFavorites();

      final isLastPage = newFavoritItems.length < apiPageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newFavoritItems);
      } else {
        final nextPageKey = pageKey + newFavoritItems.length;
        pagingController.appendPage(newFavoritItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  void deleteFav([FavoriteDataData? sonDataData]) async {
    dynamic response = await repository.deleteFavoriteApi(sonDataData);

    if (response is String) {
      Helper().showErrorToast(response);
    } else if (response) {
      newFavoritItems.removeWhere(
        (element) =>
            element.facilityId == sonDataData?.facilityId, // remove from list
      );
      pagingController.refresh();
      update();
      refresh();
      //getFavorites();
      Helper().showSuccessToast("delete_favorite_success".tr);
    }
  }

  Future<dynamic> getFavorites() async {
    dynamic response = await repository.getFavoritesApi();
    if (response is List<FavoriteDataData>) {
      //   newFavoritItems.assignAll(response);

      return response;
    } else {
      Helper().showErrorToast("Something went wrong".tr);
    }
  }
}
