import 'package:get/get.dart';
import '../../../../elements/bottom_navigation_bar.dart';
import '../../../core/utils/local_storage.dart';
import '../../../core/values/constants/general.dart';
import '../../../../helper.dart';
import '../../../data/models/city.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/auth_repository.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AuthController extends GetxController {
  final AuthRepository repository;
  AuthController({required this.repository});

  late Rx<User?> currentUser = User().obs;
  String? selectedImage;
  String? selectedIdImage;
  String? selectedPersonalImage;
  String? selectedCertificateImage;
  String? selectedFamilyIdImage;

  @override
  void onInit() {
    currentUser = LocalStorage().getUser().obs;
    super.onInit();
  }

  var isProcessEnabled = false.obs;
  RxBool passwordVisible = false.obs;
  var agreedToTOS = false.obs;

  var citiesList = <City>[].obs;

  final RoundedLoadingButtonController submitButtonController =
      RoundedLoadingButtonController();

  logout() {
    currentUser.value = null;
    GetStorage().remove(kLocalKey["userInfo"]!);
    update();
  }

  Future<dynamic> login(User user) async {
    try {
      isProcessEnabled = true.obs;
// showLoadingDialog();
      dynamic response = await repository.loginApi(user);
      if (response is User) {
        LocalStorage().saveUser(response);
        submitButtonController.success();
        currentUser = LocalStorage().getUser().obs;
        Get.to(
          () => const NavigatorPage(tabIndex: 1),
        );
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
    } else {
      isProcessEnabled = false.obs;
      submitButtonController.reset();
      Helper().showErrorToast(Helper().getErrorStringFromMap(response));
      Future.delayed(const Duration(seconds: 3), () {
        submitButtonController.reset();
      });
    }
  }

  Future<dynamic> signUp(User user) async {
    isProcessEnabled = true.obs;
    dynamic response = await repository.signUpApi(user);
    if (response is User) {
      submitButtonController.success();
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
