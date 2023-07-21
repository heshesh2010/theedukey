import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:theedukey/app/core/utils/local_storage.dart';
import 'package:theedukey/app/data/models/user.dart';

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

  RxString? selectedGender = "male".tr.obs;
  RxString selectedImage = "".obs;
  RxString selectedIdImage = "".obs;
  RxString selectedPersonalImage = "".obs;
  RxString selectedCertificateImage = "".obs;
  RxString selectedFamilyIdImage = "".obs;

  String? selectedGenderApi = "male";

  Rx<User> currentUser = Get.find<AuthService>().user;

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

  void onSelectGender(value) {
    if (value == ("male".tr)) {
      selectedGender?.value = "male".tr;
      selectedGenderApi = "male";
    } else {
      selectedGender?.value = "female".tr;
      selectedGenderApi = "female";
    }
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
    selectedGender?.value = "male".tr;
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

  void onSelectFamilyIdImage(value) {
    selectedFamilyIdImage.value = value;
    // updateApi if image != null

    update();
  }

  updateFamilyId() async {
    try {
      dynamic response = await repository.addFamilyId(
          selectedFamilyIdImage.value, currentUser.value.guardianIdNumber);

      if (response is String) {
        Helper().showErrorToast(response);
        submitButtonController.error();

        Future.delayed(const Duration(seconds: 3), () {
          Get.back();
        });
      } else if (response is SonDataData) {
        Get.back();
        submitButtonController.success();

        Future.delayed(const Duration(seconds: 3), () {
          Get.back();
        });
        Helper().showSuccessToast("update_family_id_success".tr);
        Get.find<AuthService>().user.value.familyIdImage =
            response.familyIdImage;
        LocalStorage().saveUser(Get.find<AuthService>().user.value);
      }
    } catch (e) {
      print(e);
    }
    // Get.find<AuthService>().user.value.familyIdImage =
    //     selectedFamilyIdImage.value;
    update();
  }
}
