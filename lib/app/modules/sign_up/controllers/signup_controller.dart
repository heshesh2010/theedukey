import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../helper.dart';
import '../../../data/models/city.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';
import '../../../services/settngs_service.dart';

class SignUpController extends GetxController {
  final AuthRepository repository;
  SignUpController({required this.repository});
  final terms = "".obs;
  late Rx<City> selectedCity = City(name: "choose_city".tr).obs;

  final Rx<User> currentUser = Get.find<AuthService>().user;
  String? selectedImage;
  String? selectedIdImage;
  String? selectedPersonalImage;
  String? selectedCertificateImage;
  String? selectedFamilyIdImage;
  var isProcessEnabled = false.obs;
  RxBool passwordVisible = false.obs;
  var agreedToTOS = false.obs;
  var citiesList = <City>[].obs;
  final loading = false.obs;

  final RoundedLoadingButtonController submitButtonController =
      RoundedLoadingButtonController();

  final RoundedLoadingButtonController submitVerifyButtonController =
      RoundedLoadingButtonController();

  final smsSent = ''.obs;

  @override
  void onInit() {
    getCities();
    getTerms();
    //    currentUser = LocalStorage().getUser().obs;
    super.onInit();
  }

  Future<dynamic> signUpApi() async {
    dynamic response = await repository.signUpApi(currentUser.value);
    if (response is User) {
      Get.offNamed(
        Routes.login,
      );
      Helper().showSuccessToast("sign_up_success".tr);
    } else {
      isProcessEnabled = true.obs;
      submitButtonController.error();
      //  Helper().showErrorToast(Helper().getErrorStringFromMap(response));
      Future.delayed(const Duration(seconds: 3), () {
        submitButtonController.reset();
      });
      throw Helper().getErrorStringFromMap(response);
    }
  }

  Future<void> verifyPhone() async {
    try {
      loading.value = true;
      //  await repository.sendCodeToPhone();
      await repository.verifyPhone(smsSent.value);
      await signUpApi();

      // await repository.signUpWithEmailAndPassword(
      //     currentUser.value.email ?? "", currentUser.value.password ?? "");
    } catch (e) {
      //    Get.back();
      Helper().showErrorToast(e.toString());
    } finally {
      loading.value = false;
      isProcessEnabled.value = false;
      submitVerifyButtonController.reset();

      submitButtonController.reset();
    }
  }

  Future<void> resendOTPCode() async {
    await repository.sendCodeToPhone();
    Helper().showSuccessToast("OTP_sent_successfully".tr);
  }

  Future<dynamic> signUp() async {
    isProcessEnabled = true.obs;
    loading.value = true;
    try {
      if (Get.find<SettingsService>().settings.value.mobileVerification ==
          "1") {
        await repository.sendCodeToPhone();
        await Get.toNamed(Routes.phoneVerification);
      } else {
        await signUpApi();
      }
    } catch (e) {
      isProcessEnabled = false.obs;

      Helper().showErrorToast(e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<dynamic> getCities() async {
    dynamic response = await repository.getCitiesApi();
    if (response is List<City>) {
      citiesList.addAll(response);
    } else {
      Helper().showErrorToast("Something went wrong".tr);
    }
  }

  void setSelectedCity(value) {
    selectedCity.value = value!;
    currentUser.value.city = value;
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

  void getTerms() async {
    dynamic response = await repository.termsApi();
    if (response is String) {
      terms.value = response;
    }
  }
}
