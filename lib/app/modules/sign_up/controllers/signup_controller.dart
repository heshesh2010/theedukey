import 'package:get/get.dart';
import '../../../core/utils/local_storage.dart';
import '../../../../helper.dart';
import '../../../data/models/city.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/auth_repository.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUpController extends GetxController {
  final AuthRepository repository;
  SignUpController({required this.repository});
  final terms = "".obs;
  late Rx<City> selectedCity = City(name: "choose_city".tr).obs;

  late Rx<User?> currentUser = User().obs;
  String? selectedImage;
  String? selectedIdImage;
  String? selectedPersonalImage;
  String? selectedCertificateImage;
  String? selectedFamilyIdImage;
  var isProcessEnabled = false.obs;
  RxBool passwordVisible = false.obs;
  var agreedToTOS = false.obs;
  var citiesList = <City>[].obs;
  final RoundedLoadingButtonController submitButtonController =
      RoundedLoadingButtonController();
  @override
  void onInit() {
    getCities();
    getTerms();
    currentUser = LocalStorage().getUser().obs;
    super.onInit();
  }

  Future<dynamic> signUp(User user) async {
    isProcessEnabled = true.obs;
    dynamic response = await repository.signUpApi(user);
    if (response is User) {
      submitButtonController.success();
    } else {
      isProcessEnabled = false.obs;
      submitButtonController.error();
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
      Helper().showErrorToast("Something went wrong".tr);
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

  void getTerms() async {
    dynamic response = await repository.termsApi();
    if (response is String) {
      terms.value = response;
    }
  }
}
