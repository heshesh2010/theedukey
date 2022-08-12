import 'package:get/get.dart';

import '../../../data/models/son.dart';
import '../../../data/service/locator.dart';
import '../../../data/service/search_model.dart';

class AddOrderController extends GetxController {
  late Rx<SonDataData> selectedSon =
      SonDataData(name: "Please_select_the_child".tr).obs;
  var sonsList = <SonDataData>[].obs;

  void setSelectedSon(value) {
    selectedSon.value = value!;
    getIt<SearchModel>().setSonList([value]);
  }

  SonDataData getSelectedSon() {
    return selectedSon.value;
  }
}
