import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../data/models/school.dart';
import '../../../data/models/stage.dart';
import '../../../data/repositories/home_repository.dart';
import '../../../data/service/locator.dart';
import '../../../data/service/search_model.dart';

class HomeController extends GetxController {
  final HomeRepository repository;
  HomeController({required this.repository});
  late Rx<String> aboutUs = " ".obs;
  late Rx<Stage> selectedStage =
      Stage(name: "Please_select_the_educational_stage".tr).obs;
  String pattern = '';

  @override
  void onInit() {
    getStages();
    getAboutUs();
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
    dynamic response = await repository.getStagesApi();
    if (response is List<Stage>) {
      stagesList.addAll(response);
    } else {
      //   Helper().showErrorToast("لا يمكن التسجيل حالياً يرجى المٌراجعة لاحقاً");
    }
  }

  Future<dynamic> getAboutUs() async {
    dynamic response = await repository.getAboutUsApi();
    if (response is String) {
      aboutUs.value = response;
    } else {
      //   Helper().showErrorToast("لا يمكن التسجيل حالياً يرجى المٌراجعة لاحقاً");
    }
  }

  Future<List<SchoolData>> getSuggestions(pattern) async {
    dynamic response = await repository.getSuggestionsApi(pattern);
    if (response is List<SchoolData>) {
      return response;
    } else {
      //   Helper().showErrorToast("لا يمكن التسجيل حالياً يرجى المٌراجعة لاحقاً");
    }
    return response;
  }

  void setSelectedStage(value) {
    selectedStage.value = value!;
    getIt<SearchModel>().setStageList([value]);
  }

  Stage getSelectedStage() {
    return selectedStage.value;
  }
}
