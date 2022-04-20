import 'package:get/get.dart';
import 'package:theedukey/core/langs/ar.dart';
import 'package:theedukey/core/langs/en.dart';

class Translation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}
