import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../constants/general.dart';
import '../../../../helper.dart';
import '../../../data/models/favorite.dart';
import '../../../data/repositories/favorite_repository.dart';

class FavoriteController extends GetxController {
  final FavoriteRepository repository;
  FavoriteController({required this.repository});

  var favoritesList = <FavoriteDataData>[].obs;
  final PagingController<int, FavoriteDataData> pagingController =
      PagingController(firstPageKey: 0);
  List<FavoriteDataData> newFavoritItems = [FavoriteDataData()];

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
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

  Future<dynamic> getFavorites() async {
    dynamic response = await repository.getFavoritesApi();
    if (response is List<FavoriteDataData>) {
      return response;
    } else {
      Helper().showErrorToast("حدث خطأ بالاتصال حاول لاحقاً");
    }
  }
}