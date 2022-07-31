import 'package:get_it/get_it.dart';

import 'search_model.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<SearchModel>(SearchModel());

// // Alternatively you could write it if you don't like global variables
//   GetIt.I.registerSingleton<SearchModel>(SearchModel());
}
