import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/routes/app_pages.dart';

class PermissionDeniedWidget extends StatelessWidget {
  const PermissionDeniedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      //height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Theme.of(context).focusColor.withOpacity(0.7),
                          Theme.of(context).focusColor.withOpacity(0.05),
                        ])),
                child: Icon(
                  Icons.https,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 70,
                ),
              ),
              Positioned(
                right: -30,
                bottom: -50,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.15),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
              Positioned(
                left: -20,
                top: -50,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.15),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Opacity(
            opacity: 0.4,
            child: Text("you_must_signin_to_access_to_this_section".tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2),
          ),
          const SizedBox(height: 50),
          TextButton(
            onPressed: () {
              Get.toNamed(Routes.login);
            },
            child:
                Text("login".tr, style: Theme.of(context).textTheme.headline6),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Get.toNamed(Routes.sginUp);
            },
            child: Text(
              "don't_have_an_account".tr,
              style: TextStyle(color: Theme.of(context).focusColor),
            ),
          ),
        ],
      ),
    );
  }
}
