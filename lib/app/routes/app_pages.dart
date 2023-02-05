import 'package:get/get.dart';

import '../modules/PayTab/bindings/pay_tab_binding.dart';
import '../modules/PayTab/views/pay_tab_view.dart';
import '../modules/Tamara/bindings/tamara_binding.dart';
import '../modules/Tamara/views/tamara_view.dart';
import '../modules/addOrder/bindings/add_order_binding.dart';
import '../modules/addOrder/views/add_order_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/auth/views/phone_verification_view.dart';
import '../modules/contact_us/bindings/contact_us_binding.dart';
import '../modules/contact_us/views/contact_us_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/language/bindings/language_binding.dart';
import '../modules/language/views/language_view.dart';
import '../modules/map/bindings/map_binding.dart';
import '../modules/map/views/map_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/offers/bindings/offers_binding.dart';
import '../modules/offers/views/offers_view.dart';
import '../modules/orders/bindings/orders_binding.dart';
import '../modules/orders/views/orders_view.dart';
import '../modules/paymentMethods/bindings/payment_methods_binding.dart';
import '../modules/paymentMethods/views/payment_methods_view.dart';
import '../modules/school_details/bindings/school_details_binding.dart';
import '../modules/school_details/views/school_details_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/sign_up/bindings/signup_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/sons/bindings/sons_binding.dart';
import '../modules/sons/views/add_son_view.dart';
import '../modules/sons/views/edit_son_view.dart';
import '../modules/sons/views/sons_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static final routes = [
    GetPage(
        name: _Paths.splashScreen,
        page: () => const SplashView(),
        binding: SplashBinding()),
    GetPage(
        name: _Paths.sginUp,
        page: () => SignUpView(),
        binding: SignUpBinding()),
    GetPage(
        name: _Paths.home,
        page: () => const HomeView(),
        binding: HomeBinding()),
    GetPage(name: _Paths.login, page: () => AuthView(), binding: AuthBinding()),
    GetPage(
        name: _Paths.contactUs,
        page: () => ContactUsView(),
        binding: ContactUsBinding()),
    GetPage(
        name: _Paths.editProfile,
        page: () => EditProfileView(),
        binding: EditProfileBinding()),
    GetPage(
        name: _Paths.languages,
        page: () => LanguageView(),
        binding: LanguageBinding()),
    GetPage(
        name: _Paths.notifications,
        page: () => const NotificationsView(),
        binding: NotificationsBinding()),
    GetPage(
        name: _Paths.favorite,
        page: () => const FavoriteView(),
        binding: FavoriteBinding()),
    GetPage(
        name: _Paths.orders,
        page: () => const OrdersView(),
        binding: OrdersBinding()),
    GetPage(
        name: _Paths.offers,
        page: () => const OffersView(),
        binding: OffersBinding()),
    GetPage(
        name: _Paths.sons,
        page: () => const SonsView(),
        binding: SonsBinding()),
    GetPage(
        name: _Paths.addSon, page: () => AddSonView(), binding: SonsBinding()),
    GetPage(
        name: _Paths.editSon,
        page: () => EditSonView(),
        binding: SonsBinding()),
    GetPage(
        name: _Paths.search,
        page: () => const SearchView(),
        binding: SearchBinding()),
    GetPage(name: _Paths.map, page: () => MapView(), binding: MapBinding()),
    GetPage(
        name: _Paths.schoolDetails,
        page: () => const SchoolDetailsView(),
        binding: SchoolDetailsBinding()),

    GetPage(
        name: Routes.phoneVerification,
        page: () => const PhoneVerificationView(),
        binding: AuthBinding()),

    //       GetPage(
    //   name: _Paths.webView,
    //   page: () =>  WebView(),
    //  )
    GetPage(
      name: _Paths.ADD_ORDER,
      page: () => const AddOrderView(),
      binding: AddOrderBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_METHODS,
      page: () => const PaymentMethodsView(),
      binding: PaymentMethodsBinding(),
    ),

    GetPage(
      name: _Paths.PAY_TAB,
      page: () => const PayTabView(),
      binding: PayTabBinding(),
    ),
    GetPage(
      name: _Paths.TAMARA,
      page: () => const TamaraView(),
      binding: TamaraBinding(),
    ),
  ];
}
