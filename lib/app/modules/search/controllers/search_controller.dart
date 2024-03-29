import 'package:get/get.dart';

import '../../../../helper.dart';
import '../../../data/models/facility.dart';
import '../../../data/models/filter_data.dart';
import '../../../data/models/payment_method.dart';
import '../../../data/models/rate.dart';
import '../../../data/models/stage.dart';
import '../../../data/repositories/search_repository.dart';
import '../../../data/service/locator.dart';
import '../../../data/service/search_model.dart';

class SearchControllerGetx extends GetxController {
  RxBool isLoading = true.obs;
  final SearchRepository repository;
  SearchControllerGetx({required this.repository});

  late Rx<Stage> selectedStage = Stage(name: "stage".tr).obs;
  late Rx<PaymentMethod> selectedPaymentMethod =
      PaymentMethod(name: "payment_method".tr).obs;

  var filterData = FilterDataData().obs;
  RxList<Facility> schoolList = <Facility>[].obs;

  RxList<Map<Stage, bool>> stagesCheckBoxes = <Map<Stage, bool>>[].obs;
  RxList<Map<PaymentMethod, bool>> paymentMethodsCheckBoxes =
      <Map<PaymentMethod, bool>>[].obs;

  RxList<Map<Rate, bool>> ratingsCheckBoxes = <Map<Rate, bool>>[].obs;

  List<int> listOfSelcetedStagesId = [];
  List<int> listOfSelcetedPaymentMethodsId = [];
  List<int> listOfSelcetedRatingsId = [];

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
        if (entry.value && entry.key.id != -1) {
          listOfSelcetedStagesId.add(entry.key.id ?? 0);
        } // remove dublicated
        // listOfSelcetedStagesId.removeWhere((item) => item == stage.id);
      }
    }

    updateStageDependency(listOfSelcetedStagesId);

    getSearchResults();
  }

  void setSelectedPaymentMethod(
      {required int index,
      required PaymentMethod paymentMethod,
      required bool value}) {
    paymentMethodsCheckBoxes[index].update(
      paymentMethod,
      // You can ignore the incoming parameter if you want to always update the value even if it is already in the map
      (existingValue) => value,
      ifAbsent: () => value,
    );
    listOfSelcetedPaymentMethodsId.clear();

    for (int i = 0; i < paymentMethodsCheckBoxes.length; i++) {
      for (var entry in paymentMethodsCheckBoxes[i].entries) {
        if (entry.value && entry.key.id != -1) {
          listOfSelcetedPaymentMethodsId.add(entry.key.id ?? 0);
        } // remove dublicated
        // listOfSelcetedStagesId.removeWhere((item) => item == stage.id);
      }
    }
    updatePaymentMethodDependency(listOfSelcetedPaymentMethodsId);
    getSearchResults();
  }

  unCheckAllSelectedStagesCheckBoxes() {
    listOfSelcetedStagesId.clear();
    for (int i = 0; i < stagesCheckBoxes.length; i++) {
      if (!stagesCheckBoxes[i].containsKey(Stage(id: -1, name: "all".tr))) {
        stagesCheckBoxes[i].update(
            Stage(
                id: stagesCheckBoxes[i].keys.first.id,
                name: stagesCheckBoxes[i].keys.first.name),
            (value) => false);
      }
    }
  }

  checkAllSelectedStagesCheckBoxes() {
    listOfSelcetedStagesId.clear();
    for (int i = 0; i < stagesCheckBoxes.length; i++) {
      if (!stagesCheckBoxes[i].containsKey(Stage(id: -1, name: "all".tr))) {
        stagesCheckBoxes[i].update(
            Stage(
                id: stagesCheckBoxes[i].keys.first.id,
                name: stagesCheckBoxes[i].keys.first.name),
            (value) => true);
      }
    }
  }

  unCheckAllSelectedRatingCheckBoxes() {
    listOfSelcetedRatingsId.clear();
    for (int i = 0; i < ratingsCheckBoxes.length; i++) {
      if (!ratingsCheckBoxes[i].containsKey(Rate(-1, "all".tr))) {
        ratingsCheckBoxes[i].update(
            Rate(ratingsCheckBoxes[i].keys.first.id,
                ratingsCheckBoxes[i].keys.first.name),
            (value) => false);
      }
    }
  }

  checkAllSelectedRatingCheckBoxes() {
    listOfSelcetedRatingsId.clear();
    for (int i = 0; i < ratingsCheckBoxes.length; i++) {
      if (!ratingsCheckBoxes[i].containsKey(Rate(-1, "all".tr))) {
        ratingsCheckBoxes[i].update(
            Rate(ratingsCheckBoxes[i].keys.first.id,
                ratingsCheckBoxes[i].keys.first.name),
            (value) => true);
      }
    }
  }

  unCheckAllSelectedPaymentMethodsCheckBoxes() {
    listOfSelcetedPaymentMethodsId.clear();
    for (int i = 0; i < paymentMethodsCheckBoxes.length; i++) {
      if (!paymentMethodsCheckBoxes[i]
          .containsKey(PaymentMethod(id: -1, name: "all".tr))) {
        paymentMethodsCheckBoxes[i].update(
            PaymentMethod(
                id: paymentMethodsCheckBoxes[i].keys.first.id,
                name: paymentMethodsCheckBoxes[i].keys.first.name),
            (value) => false);
      }
    }
  }

  checkAllSelectedPaymentMethodsCheckBoxes() {
    listOfSelcetedPaymentMethodsId.clear();
    for (int i = 0; i < paymentMethodsCheckBoxes.length; i++) {
      if (!paymentMethodsCheckBoxes[i]
          .containsKey(PaymentMethod(id: -1, name: "all".tr))) {
        paymentMethodsCheckBoxes[i].update(
            PaymentMethod(
                id: paymentMethodsCheckBoxes[i].keys.first.id,
                name: paymentMethodsCheckBoxes[i].keys.first.name),
            (value) => true);
      }
    }
  }

  setSelectedRatingCheckBox(
      {required int index, required Rate rateing, required bool value}) {
    ratingsCheckBoxes[index].update(
      rateing,
      // You can ignore the incoming parameter if you want to always update the value even if it is already in the map
      (existingValue) => value,
      ifAbsent: () => value,
    );
    listOfSelcetedRatingsId.clear();

    for (int i = 0; i < ratingsCheckBoxes.length; i++) {
      for (var entry in ratingsCheckBoxes[i].entries) {
        if (entry.value && entry.key.id != -1) {
          listOfSelcetedRatingsId.add(entry.key.id);
        } // remove dublicated
        // listOfSelcetedStagesId.removeWhere((item) => item == stage.id);
      }
    }

    updateRatingDependency(listOfSelcetedRatingsId);

    getSearchResults();
  }

  updatePaymentMethodDependency(value) {
    getIt<SearchModel>().setPaymentMethodList(value);
  }

  updateStageDependency(value) {
    getIt<SearchModel>().setStageList(value);
  }

  updateRatingDependency(value) {
    getIt<SearchModel>().setRatingList(value);
  }

  getSearchResults() async {
    schoolList.clear();
    isLoading.value = true;

    dynamic response = await repository.getSearchResultsApi();
    if (response is List<Facility>) {
      schoolList.assignAll(response);
      getIt<SearchModel>().setSchoolsList(schoolList);
      isLoading.value = false;

      update();
    } else {
      isLoading.value = false;
      Helper().showErrorToast("Something went wrong".tr);
      update();
    }
  }

  Future<dynamic> getFilterData() async {
    dynamic response = await repository.getFilterDataApi();
    if (response is FilterDataData) {
      filterData.value = response;
      for (int i = 0; i < filterData.value.stages!.length; i++) {
        stagesCheckBoxes.add({filterData.value.stages![i]: false});
      }

      for (int i = 0; i < filterData.value.paymentMethods!.length; i++) {
        paymentMethodsCheckBoxes
            .add({filterData.value.paymentMethods![i]: false});
      }

      for (int i = 0; i < filterData.value.ratings!.length; i++) {
        ratingsCheckBoxes.add({filterData.value.ratings![i]: false});
      }
    } else {
      Helper().showErrorToast("Something went wrong".tr);
    }
  }
}
