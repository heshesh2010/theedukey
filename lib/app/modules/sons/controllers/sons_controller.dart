import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../../constants/general.dart';
import '../../../../helper.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/utils/local_storage.dart';
import '../../../data/models/son.dart';
import '../../../data/repositories/sons_repository.dart';

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

  final List<String> gender = ["male".tr, "female".tr];

  String? selectedGender = "male".tr;
  String? selectedImage;
  String? selectedIdImage;
  String? selectedPersonalImage;
  String? selectedCertificateImage;
  String? selectedGenderApi = "male";

  String? selectedFamilyIdImage;

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      newSonsItems.clear();
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
      sonsList.addAll(response);
      return sonsList;
    } else {
      Helper().showErrorToast("حدث خطأ بالاتصال حاول لاحقاً");
    }
  }

  void onSelectIdImage(value) {
    selectedIdImage = value;
    update();
  }

  void onSelectPersonalImage(value) {
    selectedPersonalImage = value;
    update();
  }

  void onSelectCertificateImage(value) {
    selectedCertificateImage = value;
    update();
  }

  void onSelectFamilyIdImage(value) {
    selectedFamilyIdImage = value;
    // updateApi if image != null
    update();
  }

  void onSelectGender(value) {
    if (value.contains("male".tr)) {
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

      Future.delayed(const Duration(seconds: 3), () {
        Get.back();
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

  void deleteSon([SonDataData? sonDataData]) async {
    dynamic response = await repository.deleteSonApi(sonDataData);
    if (response) {
      sonsList.remove(sonDataData);
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
    selectedImage = null;
    selectedGender = "male".tr;
    selectedIdImage = null;
    selectedPersonalImage = null;
    selectedCertificateImage = null;
    selectedGenderApi = "male";
  }

  bool isFamilyIdExits() {
    return LocalStorage().getUser()?.familyIdImage != null ? true : false;
  }

  updateFamilyId() {}
}
