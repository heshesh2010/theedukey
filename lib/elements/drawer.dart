import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/helper.dart';
import '../app/modules/auth/controllers/auth_controller.dart';
import '../app/modules/favorite/controllers/favorite_controller.dart';
import '../app/modules/home/bindings/home_binding.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../app/routes/app_pages.dart';
import '../app/services/auth_service.dart';
import '../navigator_controller.dart';
import 'bottom_navigation_bar.dart';

class DrawerSideMenu extends StatelessWidget {
  DrawerSideMenu({Key? key}) : super(key: key);

  final AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Get.find<AuthService>().isAuth
        ? Drawer(
            backgroundColor: const Color(0xFF414755),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 80.0, bottom: 8, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 80.0,
                          width: 80.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              //     maxHeightDiskCache: 10,
                              imageUrl:
                                  controller.currentUser.value.image ?? "",
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fadeOutDuration: const Duration(seconds: 1),
                              fadeInDuration: const Duration(seconds: 3),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              controller.currentUser.value.name ?? "",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                            Text(
                              controller.currentUser.value.nameEn ?? " ",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home, color: Colors.white),
                    title: Text('home'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == Routes.navigator ||
                          Get.currentRoute == Routes.home) {
                        Get.back();
                        final navigatorController =
                            Get.find<NavigatorController>();
                        navigatorController.changePage(1);
                      } else {
                        Get.to(() => const NavigatorPage(),
                            binding: HomeBinding());
                        Get.find<NavigatorController>().changePage(1);
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.notifications, color: Colors.white),
                    title: Text('notifications'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == Routes.notifications ||
                          Get.currentRoute == Routes.navigator) {
                        final navigatorController =
                            Get.find<NavigatorController>();
                        navigatorController.changePage(2);
                        Get.back();
                      } else {
                        Get.to(() => const NavigatorPage(),
                            binding: HomeBinding());
                        Get.find<NavigatorController>().changePage(2);
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.white),
                    title: Text('edit_profile'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == Routes.editProfile) {
                        Get.back();
                      } else {
                        Get.toNamed(Routes.editProfile);
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  ListTile(
                    leading: const Icon(Icons.star, color: Colors.white),
                    title: Text('favorite'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == Routes.favorite) {
                        Get.back();
                      } else {
                        Get.delete<FavoriteController>();
                        Get.toNamed(Routes.favorite);
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  ListTile(
                    leading: const Icon(Icons.file_copy, color: Colors.white),
                    title: Text('my_orders'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == Routes.orders ||
                          Get.currentRoute == Routes.navigator) {
                        final navigatorController =
                            Get.find<NavigatorController>();
                        navigatorController.changePage(0);
                        Get.back();
                      } else {
                        Get.to(() => const NavigatorPage(),
                            binding: HomeBinding());
                        Get.find<NavigatorController>().changePage(0);
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  ListTile(
                    leading: const Icon(Icons.local_offer_sharp,
                        color: Colors.white),
                    title: Text('offers'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == Routes.offers) {
                        Get.back();
                      } else {
                        Get.toNamed(Routes.offers);
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.family_restroom, color: Colors.white),
                    title: Text('sons'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == Routes.sons) {
                        Get.back();
                      } else {
                        Get.toNamed(Routes.sons);
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  ListTile(
                    leading: const Icon(Icons.language, color: Colors.white),
                    title: Text('language'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == Routes.languages) {
                        Get.back();
                      } else {
                        Get.offAndToNamed(Routes.languages);
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  ListTile(
                    leading: const Icon(Icons.mail, color: Colors.white),
                    title: Text('contact_us'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == Routes.contactUs) {
                        Get.back();
                      } else {
                        Get.toNamed(Routes.contactUs);
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.white),
                    title: Text('delete_account'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      Helper().showCustomDialog(
                        'delete_account'.tr,
                        'delete_account_desc'.tr,
                        onCancel: () {
                          Get.back();
                        },
                        onConfirm: () {
                          controller.deleteAccount();
                        },
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.white),
                    title: Text('logout'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      controller.logout();
                    },
                  ),
                ],
              ),
            ),
          )
        : Drawer(
            backgroundColor: const Color(0xFF414755),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 60.0, bottom: 8, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 80,
                          height: 100,
                        ),
                        Text(
                          "guest".tr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home, color: Colors.white),
                    title: Text('home'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == Routes.navigator ||
                          Get.currentRoute == Routes.home) {
                        Get.back();
                        final navigatorController =
                            Get.find<NavigatorController>();
                        navigatorController.changePage(1);
                      } else {
                        Get.to(() => const NavigatorPage(),
                            binding: HomeBinding());
                        Get.find<NavigatorController>().changePage(1);
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  ListTile(
                    leading: const Icon(Icons.local_offer_sharp,
                        color: Colors.white),
                    title: Text('offers'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == Routes.offers) {
                        Get.back();
                      } else {
                        Get.toNamed(Routes.offers);
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  ListTile(
                    leading: const Icon(Icons.language, color: Colors.white),
                    title: Text('language'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == Routes.languages) {
                        Get.back();
                      } else {
                        Get.toNamed(Routes.languages);
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  ListTile(
                    leading: const Icon(Icons.mail, color: Colors.white),
                    title: Text('contact_us'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == Routes.contactUs) {
                        Get.back();
                      } else {
                        Get.toNamed(Routes.contactUs);
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(color: Colors.grey),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.white),
                    title: Text('login'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      Get.toNamed(Routes.login);
                    },
                  ),
                ],
              ),
            ));
  }
}
