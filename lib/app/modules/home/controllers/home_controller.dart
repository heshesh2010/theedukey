import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../data/models/stage.dart';
import '../../../data/repositories/home_repository.dart';

class HomeController extends GetxController {
  late Rx<Stage> selectedStage =
      Stage(name: "من فضلك اختر المرحلة التعليمية".tr).obs;
  @override
  void onInit() {
    getStages();
    super.onInit();
  }

  var stagesList = <Stage>[].obs;
  final RoundedLoadingButtonController btnLoginController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnSignUpController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnForgetController =
      RoundedLoadingButtonController();

  Future<dynamic> getStages() async {
    dynamic response = await getStagesApi();
    if (response is List<Stage>) {
      stagesList.addAll(response);
    } else {
      //   Helper().showErrorToast("لا يمكن التسجيل حالياً يرجى المٌراجعة لاحقاً");
    }
  }

  void setSelectedStage(value) {
    selectedStage.value = value!;
  }
}
