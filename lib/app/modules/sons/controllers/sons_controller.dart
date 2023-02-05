import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../constants/general.dart';
import '../../../../helper.dart';
import '../../../data/models/son.dart';
import '../../../data/repositories/sons_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';

class SonsController extends GetxController {
  final SonsRepository repository;
  SonsController({required this.repository});

  var sonsList = <SonDataData>[].obs;
  final PagingController<int, SonDataData> pagingController =
      PagingController(firstPageKey: 0);
  List<SonDataData> newSonsItems = [SonDataData()];

  var isProcessEnabled = false.obs;
  final RoundedLoadingButtonController submitButtonController =
      RoundedLoadingButtonController();

  List<String> gender = ["male".tr, "female".tr];

  String? selectedGender = "male".tr;
  RxString selectedImage = "".obs;
  RxString selectedIdImage = "".obs;
  RxString selectedPersonalImage = "".obs;
  RxString selectedCertificateImage = "".obs;
  RxString selectedFamilyIdImage = "".obs;

  String? selectedGenderApi = "male";

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      newSonsItems.clear();
      sonsList.clear();
      _fetchSonsPage(pageKey);
    });
    super.onInit();
  }

  Future<void> _fetchSonsPage(pageKey) async {
    try {
      newSonsItems = await getSons();
      final isLastPage = newSonsItems.length < apiPageSize;
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

  Future<dynamic> getSons() async {
    dynamic response = await repository.getSonsApi();
    if (response is List<SonDataData>) {
      sonsList.assignAll(response);
      return sonsList;
    } else {
      Helper().showErrorToast("Something went wrong".tr);
    }
  }

  void onSelectIdImage(value) {
    selectedIdImage.value = value;
    update();
  }

  void onSelectPersonalImage(value) {
    selectedPersonalImage.value = value;
    update();
  }

  void onSelectCertificateImage(value) {
    selectedCertificateImage.value = value;
    update();
  }

  void onSelectFamilyIdImage(value) {
    selectedFamilyIdImage.value = value;
    // updateApi if image != null
    update();
  }

  void onSelectGender(value) {
    if (value == ("male".tr)) {
      selectedGender = "male".tr;
      selectedGenderApi = "male";
    } else {
      selectedGender = "female".tr;
      selectedGenderApi = "female";
    }

    update();
  }

  addSon([SonDataData? sonDataData]) async {
    dynamic response = await repository.addSonApi(sonDataData);
    if (response is SonDataData) {
      submitButtonController.success();
      Helper().showSuccessToast("add_son_success".tr);
      sonsList.clear();

      getSons();
      pagingController.refresh();
      //   update();
      Get.toNamed(Routes.sons);
    } else {
      submitButtonController.error();
      Future.delayed(const Duration(seconds: 3), () {
        submitButtonController.reset();
      });
      if (response is String) {
        Helper().showErrorToast(response);
      } else {
        Helper().showErrorToast(response.statusMessage.toString());
      }
    }
  }

  void deleteSon([SonDataData? sonDataData]) async {
    dynamic response = await repository.deleteSonApi(sonDataData);
    if (response) {
      sonsList.clear();
      submitButtonController.success();
      Helper().showSuccessToast("delete_son_success".tr);

      Future.delayed(const Duration(seconds: 3), () {
        pagingController.refresh();
        update();
      });
    } else {
      submitButtonController.error();

      Future.delayed(const Duration(seconds: 3), () {
        submitButtonController.reset();
      });
      if (response is String) {
        Helper().showErrorToast(response);
      } else {
        Helper().showErrorToast(response.statusMessage.toString());
      }
    }
  }

  editSon([SonDataData? sonDataData]) async {
    dynamic response = await repository.editSonApi(sonDataData);
    if (response is SonDataData) {
      submitButtonController.success();
      Helper().showSuccessToast("edit_son_success".tr);

      Future.delayed(const Duration(seconds: 3), () {
        update();
        Get.back();
      });
    } else {
      submitButtonController.error();

      Future.delayed(const Duration(seconds: 3), () {
        submitButtonController.reset();
      });
      if (response is String) {
        Helper().showErrorToast(response);
      } else {
        Helper().showErrorToast(response.statusMessage.toString());
      }
    }
  }

  void clearAllVars() {
    gender = ["male".tr, "female".tr];
    selectedImage.value = "";
    selectedGender = "male".tr;
    selectedIdImage.value = "";
    selectedPersonalImage.value = "";
    selectedCertificateImage.value = "";
    selectedGenderApi = "male";
  }

  bool isFamilyIdExits() {
    return Get.find<AuthService>().user.value.familyIdImage != null
        ? true
        : false;
  }

  updateFamilyId() {}
}
