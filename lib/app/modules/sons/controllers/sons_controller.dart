import 'package:get/get.dart';
import '../../../../helper.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../data/models/son.dart';
import '../../../data/repositories/sons_repository.dart';

class SonsController extends GetxController {
  var sonsList = <SonData>[].obs;
  final PagingController<int, SonData> pagingController =
      PagingController(firstPageKey: 0);
  static const _pageSonsSize = 15;
  List<SonData> newSonsItems = [SonData()];

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
        newSonsItems = await getSons();
      } else {
        newSonsItems = await getSons(nextUrl: nextUrl);
      }

      final isLastPage = newSonsItems.length < _pageSonsSize || nextUrl == null;
      if (isLastPage) {
        pagingController.appendLastPage(newSonsItems);
      } else {
        final nextPageKey = pageKey + newSonsItems.length;
        pagingController.appendPage(newSonsItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<dynamic> getSons({nextUrl}) async {
    dynamic response = await getSonsApi(nextUrl: nextUrl);
    if (response is List<SonData>) {
      sonsList.addAll(response);
      return sonsList;
    } else {
      Helper().showErrorToast("حدث خطأ بالاتصال حاول لاحقاً");
    }
  }
}
