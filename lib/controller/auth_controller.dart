import 'package:get/get.dart';
import 'package:theedukey/screens/home_screen.dart';
import '../constants/general.dart';
import '../helper.dart';
import '../models/city.dart';
import '../models/user.dart';
import '../repo/auth_repository.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AuthController extends GetxController {
  late Rx<City> selectedCity = City(name: "اختر المدينة").obs;

  late Rx<User?> currentUser = User().obs;

  @override
  void onInit() {
    getCities();
    currentUser = getUser().obs;
    super.onInit();
  }

  var loginProcess = false.obs;
  var signUpProcess = false.obs;
  var forgetProcess = false.obs;

  var agreedToTOS = false.obs;

  var citiesList = <City>[].obs;

  final RoundedLoadingButtonController btnLoginController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnSignUpController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnForgetController =
      RoundedLoadingButtonController();

  logout() {
    currentUser.value = null;
    GetStorage().remove(kLocalKey["userInfo"]!);
    update();
  }

  Future<dynamic> login(User user) async {
    try {
      loginProcess = true.obs;
// showLoadingDialog();
      dynamic response = await loginApi(user);
      if (response is User) {
        GetStorage().write(kLocalKey["userInfo"]!, response);
        btnLoginController.success();
        currentUser = getUser().obs;
        Get.to(() => const HomeScreen());
        loginProcess = false.obs;

        //  Get.back();
      } else {
        loginProcess = false.obs;
        btnLoginController.error();
        if (response is String) {
          Helper().showErrorToast(response);
        } else {
          Helper().showErrorToast(response.statusMessage.toString());
        }
      }
    } on Exception catch (exception) {
      Helper().showErrorToast(exception.toString());

      Future.delayed(const Duration(seconds: 3), () {
        btnLoginController.reset();
      });
    }
  }

  Future<dynamic> forget(User user) async {
    forgetProcess = true.obs;
// showLoadingDialog();
    dynamic response = await forgetApi(user);
    if (response is User) {
      btnLoginController.success();
      //  Get.back();
    } else {
      loginProcess = false.obs;
      btnForgetController.error();
      Helper().showErrorToast(response.statusMessage.toString());
      Future.delayed(const Duration(seconds: 3), () {
        btnForgetController.reset();
      });
    }
  }

  Future<dynamic> signUp(User user) async {
    signUpProcess = true.obs;
    dynamic response = await signUpApi(user);
    if (response is User) {
      btnSignUpController.success();
    } else {
      signUpProcess = false.obs;
      btnSignUpController.reset();
      Helper().showErrorToast(response?.data["errors"] != null
          ? Helper().getErrorString(response.data["errors"].values.toList())
          : response.statusMessage.toString());
      Future.delayed(const Duration(seconds: 3), () {
        btnSignUpController.reset();
      });
    }
  }

  Future<dynamic> getCities() async {
    dynamic response = await getCitiesApi();
    if (response is List<City>) {
      citiesList.addAll(response);
    } else {
      Helper().showErrorToast("لا يمكن التسجيل حالياً يرجى المٌراجعة لاحقاً");
    }
  }

  void setSelectedCity(value) {
    selectedCity.value = value!;
  }

  User? getUser() {
    if (GetStorage().read(kLocalKey["userInfo"]!) != null) {
      return User.fromJson(GetStorage().read(kLocalKey["userInfo"]!));
    } else {
      return null;
    }
  }
}
