import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../helper.dart';
import '../../../data/models/favorite.dart';
import '../../../data/repositories/favorite_repository.dart';

class FavoriteController extends GetxController {
  var favoritesList = <Favorite>[].obs;
  final PagingController<int, Favorite> pagingController =
      PagingController(firstPageKey: 0);
  static const _pageFavoriteSize = 15;
  List<Favorite> newFavoritItems = [Favorite()];

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
        newFavoritItems = await getFavorites();
      } else {
        newFavoritItems = await getFavorites(nextUrl: nextUrl);
      }

      final isLastPage =
          newFavoritItems.length < _pageFavoriteSize || nextUrl == null;
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

  Future<dynamic> getFavorites({nextUrl}) async {
    dynamic response = await getFavoritesApi(nextUrl: nextUrl);
    if (response is List<Favorite>) {
      favoritesList.addAll(response);
      return favoritesList;
    } else {
      Helper().showErrorToast("حدث خطأ بالاتصال حاول لاحقاً");
    }
  }
}
