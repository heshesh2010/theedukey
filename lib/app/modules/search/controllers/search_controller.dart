import 'package:get/get.dart';

import '../../../../helper.dart';
import '../../../data/models/filter_data.dart';
import '../../../data/models/payment_method.dart';
import '../../../data/models/school.dart';
import '../../../data/models/stage.dart';
import '../../../data/repositories/search_repository.dart';
import '../../../data/service/locator.dart';
import '../../../data/service/search_model.dart';

class SearchController extends GetxController {
  final SearchRepository repository;
  SearchController({required this.repository});

  late Rx<Stage> selectedStage = Stage(name: "stage".tr).obs;
  late Rx<PaymentMethod> selectedPaymentMethod =
      PaymentMethod(name: "payment_method".tr).obs;

  var filterData = FilterDataData().obs;
  var schoolList = <SchoolData>[].obs;

  RxList<Map<Stage, bool>> stagesCheckBoxes = <Map<Stage, bool>>[].obs;
  List<int> listOfSelcetedStagesId = [];

  @override
  void onInit() {
    // selectedStage.value = Get.find<HomeController>().getSelectedStage();

    // selectedStage.value =
    //     getIt<SearchModel>().routeArgument?.stage ?? Stage(name: "stage".tr);
    getFilterData();
    getSearchResults();
    super.onInit();
  }

  setSelectedStageCheckBox(
      {required int index, required Stage stage, required bool value}) {
    stagesCheckBoxes[index].update(
      stage,
      // You can ignore the incoming parameter if you want to always update the value even if it is already in the map
      (existingValue) => value,
      ifAbsent: () => value,
    );
    listOfSelcetedStagesId.clear();

    for (int i = 0; i < stagesCheckBoxes.length; i++) {
      for (var entry in stagesCheckBoxes[i].entries) {
        if (entry.value) {
          listOfSelcetedStagesId.add(entry.key.id ?? 0);
        } // remove dublicated
        // listOfSelcetedStagesId.removeWhere((item) => item == stage.id);

      }
    }

    updateStageDependency(listOfSelcetedStagesId);

    getSearchResults();
  }

  void setSelectedPaymentMethod(value) {
    selectedPaymentMethod.value = value!;
    updatePaymentMethodDependency(value);
    getSearchResults();
  }

  updatePaymentMethodDependency(value) {
    getIt<SearchModel>().setPaymentMethod(value);
  }

  updateStageDependency(value) {
    getIt<SearchModel>().setStageList(value);
  }

  getSearchResults() async {
    schoolList.clear();
    dynamic response = await repository.getSearchResultsApi();
    if (response is List<SchoolData>) {
      schoolList.addAll(response);
      update();
    } else {
      Helper().showErrorToast("حدث خطأ ما يرجى المحاولة مرة اخرى");
    }
  }

  Future<dynamic> getFilterData() async {
    dynamic response = await repository.getFilterDataApi();
    if (response is FilterDataData) {
      filterData.value = response;
      for (int i = 0; i < filterData.value.stages!.length; i++) {
        stagesCheckBoxes.add({filterData.value.stages![i]: false});
      }
    } else {
      Helper().showErrorToast("حدث خطأ ما يرجى المحاولة مرة اخرى");
    }
  }
}
