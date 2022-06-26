import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/modules/auth/controllers/auth_controller.dart';
import '../app/modules/home/bindings/home_binding.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../app/core/utils/local_storage.dart';
import '../app/routes/route_list.dart';
import '../navigator_controller.dart';
import 'bottom_navigation_bar.dart';

class DrawerSideMenu extends GetView<AuthController> {
  const DrawerSideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocalStorage().getUser() != null
        ? Drawer(
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
                        Container(
                          height: 80.0,
                          width: 100.0,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                          child: CachedNetworkImage(
                            maxHeightDiskCache: 10,
                            imageUrl:
                                controller().currentUser.value?.image ?? "",
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fadeOutDuration: const Duration(seconds: 1),
                            fadeInDuration: const Duration(seconds: 3),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              controller().currentUser.value?.name ?? "",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(color: Colors.white),
                            ),
                            Text(
                              controller().currentUser.value?.nameEn ?? " ",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
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
                            .subtitle1
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == RouteList.navigator) {
                        final navigatorController =
                            Get.find<NavigatorController>();
                        navigatorController.changePage(1);
                        Get.back();
                      } else {
                        Get.to(() => const NavigatorPage(tabIndex: 1),
                            binding: HomeBinding());
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
                            .subtitle1
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == RouteList.navigator) {
                        final navigatorController =
                            Get.find<NavigatorController>();
                        navigatorController.changePage(0);
                        Get.back();
                      } else {
                        Get.to(() => const NavigatorPage(tabIndex: 0),
                            binding: HomeBinding());
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
                            .subtitle1
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == RouteList.editProfile) {
                        Get.back();
                      } else {
                        Get.toNamed(RouteList.editProfile);
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
                            .subtitle1
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == RouteList.favorite) {
                        Get.back();
                      } else {
                        Get.toNamed(RouteList.favorite);
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
                            .subtitle1
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == RouteList.orders) {
                        Get.back();
                      } else {
                        Get.toNamed(RouteList.orders);
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
                            .subtitle1
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == RouteList.offers) {
                        Get.back();
                      } else {
                        Get.toNamed(RouteList.offers);
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
                            .subtitle1
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == RouteList.sons) {
                        Get.back();
                      } else {
                        Get.toNamed(RouteList.sons);
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
                            .subtitle1
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == RouteList.languages) {
                        Get.back();
                      } else {
                        Get.toNamed(RouteList.languages);
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
                            .subtitle1
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == RouteList.contactUs) {
                        Get.back();
                      } else {
                        Get.toNamed(RouteList.contactUs);
                      }
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
                            .subtitle1
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      controller().logout();
                      Get.back();
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
                              .subtitle1
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
                            .subtitle1
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == RouteList.home) {
                        Get.back();
                      } else {
                        Get.to(() => const NavigatorPage(tabIndex: 0),
                            binding: HomeBinding());
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
                            .subtitle1
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == RouteList.offers) {
                        Get.back();
                      } else {
                        Get.toNamed(RouteList.offers);
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
                            .subtitle1
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == RouteList.languages) {
                        Get.back();
                      } else {
                        Get.toNamed(RouteList.languages);
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
                            .subtitle1
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      if (Get.currentRoute == RouteList.contactUs) {
                        Get.back();
                      } else {
                        Get.toNamed(RouteList.contactUs);
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
                            .subtitle1
                            ?.copyWith(color: Colors.white)),
                    onTap: () {
                      Get.toNamed(RouteList.login);
                    },
                  ),
                ],
              ),
            ));
  }
}
