import 'package:get/get.dart';
import '../modules/orders/bindings/orders_binding.dart';
import '../modules/orders/views/orders_view.dart';
import '../modules/sons/views/add_son_view.dart';
import '../modules/auth/views/sign_up_view.dart';
import '../modules/contact_us/bindings/contact_us_binding.dart';
import '../modules/sons/views/edit_son_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/splash/views/splash_view.dart';
import 'route_list.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/contact_us/views/contact_us_view.dart';
import '../modules/auth/views/edit_profile_view.dart';
import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/language/views/language_view.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/offers/bindings/offers_binding.dart';
import '../modules/offers/views/offers_view.dart';
import '../modules/sons/bindings/sons_binding.dart';
import '../modules/sons/views/sons_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/language/bindings/language_binding.dart';
import '../modules/splash/bindings/splash_binding.dart';

class AppPages {
  static final routes = [
    GetPage(
        name: RouteList.splashScreen,
        page: () => const SplashView(),
        binding: SplashBinding()),
    GetPage(
        name: RouteList.sginUp,
        page: () => SignUpView(),
        binding: AuthBinding()),
    GetPage(
        name: RouteList.home,
        page: () => const HomeView(),
        binding: HomeBinding()),
    GetPage(
        name: RouteList.login, page: () => AuthView(), binding: AuthBinding()),
    GetPage(
        name: RouteList.contactUs,
        page: () => ContactUsView(),
        binding: ContactUsBinding()),
    GetPage(
        name: RouteList.editProfile,
        page: () => EditProfileView(),
        binding: AuthBinding()),
    GetPage(
        name: RouteList.languages,
        page: () => LanguageView(),
        binding: LanguageBinding()),
    GetPage(
        name: RouteList.notifications,
        page: () => const NotificationsView(),
        binding: FavoriteBinding()),
    GetPage(
        name: RouteList.favorite,
        page: () => const FavoriteView(),
        binding: FavoriteBinding()),
    GetPage(
        name: RouteList.orders,
        page: () => const OrdersView(),
        binding: OrdersBinding()),
    GetPage(
        name: RouteList.offers,
        page: () => const OffersView(),
        binding: OffersBinding()),
    GetPage(
        name: RouteList.sons,
        page: () => const SonsView(),
        binding: SonsBinding()),
    GetPage(
        name: RouteList.addSon,
        page: () => AddSonView(),
        binding: SonsBinding()),
    GetPage(
        name: RouteList.editSon,
        page: () => EditSonView(),
        binding: SonsBinding())
  ];
}
