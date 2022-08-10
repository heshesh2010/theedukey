import 'package:get/get.dart';

import '../../../../helper.dart';
import '../../../data/models/facility.dart';
import '../../../data/repositories/school_repository.dart';

class SchoolDetailsController extends GetxController {
  final SchoolRepository repository;
  SchoolDetailsController({required this.repository});
  RxBool isLoading = true.obs;
  RxInt selectedPage = 0.obs;

  late Rx<Facility> facility = Facility().obs;
  @override
  void onInit() {
    super.onInit();

    getFacility();
  }

  void getFacility() async {
    dynamic response = await repository.getFacilityApi();
    if (response is Facility) {
      facility.value = response;
      isLoading.value = false;
    } else {
      Helper().showErrorToast("حدث خطأ ما يرجى المحاولة مرة اخرى");
    }
  }
}
