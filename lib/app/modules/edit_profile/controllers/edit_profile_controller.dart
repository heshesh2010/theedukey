import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../helper.dart';
import '../../../core/utils/local_storage.dart';
import '../../../data/models/city.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';

class EditProfileController extends GetxController {
  final AuthRepository repository;
  EditProfileController({required this.repository});

  late Rx<City> selectedCity = City(name: "choose_city".tr).obs;

  late Rx<User?> currentUser = Get.find<AuthService>().user;
  String? selectedImage;
  String? selectedIdImage;
  String? selectedPersonalImage;
  String? selectedCertificateImage;
  String? selectedFamilyIdImage;

  @override
  void onInit() {
    getCities();
    super.onInit();
  }

  var isProcessEnabled = false.obs;
  RxBool passwordVisible = false.obs;
  var agreedToTOS = false.obs;

  var citiesList = <City>[].obs;

  final RoundedLoadingButtonController submitButtonController =
      RoundedLoadingButtonController();

  Future<dynamic> login(User user) async {
    try {
      isProcessEnabled = true.obs;
// showLoadingDialog();
      dynamic response = await repository.loginApi(user);
      if (response is User) {
        LocalStorage().saveUser(response);
        submitButtonController.success();
        response.auth = true;

        currentUser.value = response;
        Get.toNamed(Routes.home);
        isProcessEnabled = false.obs;

        //  Get.back();
      } else {
        isProcessEnabled = false.obs;
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
    } on Exception catch (exception) {
      Helper().showErrorToast(exception.toString());

      Future.delayed(const Duration(seconds: 3), () {
        submitButtonController.reset();
      });
    }
  }

  Future<dynamic> forget(User user) async {
    isProcessEnabled = true.obs;
// showLoadingDialog();
    dynamic response = await repository.forgetApi(user);
    if (response is User) {
      submitButtonController.success();
      //  Get.back();
    } else {
      isProcessEnabled = false.obs;
      submitButtonController.error();
      Helper().showErrorToast(response.statusMessage.toString());
      Future.delayed(const Duration(seconds: 3), () {
        submitButtonController.reset();
      });
    }
  }

  Future<dynamic> updateProfile(User user) async {
    isProcessEnabled = true.obs;
    dynamic response = await repository.updateProfileApi(user);
    if (response is User) {
      submitButtonController.success();
      isProcessEnabled = false.obs;

      User tempUser = response;
      tempUser.token = currentUser.value!.token;

      LocalStorage().saveUser(tempUser);
      Get.back();

      Helper().showSuccessToast("profile_updated".tr);
    } else {
      isProcessEnabled = false.obs;
      submitButtonController.reset();
      Helper().showErrorToast(Helper().getErrorStringFromMap(response));
      Future.delayed(const Duration(seconds: 3), () {
        submitButtonController.reset();
      });
    }
  }

  Future<dynamic> getCities() async {
    dynamic response = await repository.getCitiesApi();
    if (response is List<City>) {
      citiesList.addAll(response);
    } else {
      Helper().showErrorToast("لا يمكن التسجيل حالياً يرجى المٌراجعة لاحقاً");
    }
  }

  void setSelectedCity(value) {
    selectedCity.value = value!;
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
}
