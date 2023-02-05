import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../../elements/drawer.dart';
import '../../../../elements/topbar.dart';
import '../controllers/pay_tab_controller.dart';

class PayTabView extends GetWidget<PayTabController> {
  const PayTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: getTopBar(context, title: "pay_with_payTab".tr, isback: true),
        drawer: DrawerSideMenu(),
        body: Column(children: <Widget>[
          Obx(() {
            if (controller.isLoading.isTrue) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Expanded(
              child: Container(
                color: Colors.grey,
                child: InAppWebView(
                  initialUrlRequest:
                      URLRequest(url: Uri.parse(controller.url.value)),
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                    incognito: true,
                    clearCache: true,
                  )),
                  onWebViewCreated: (InAppWebViewController wvcontroller) {},
                  onLoadStop: (InAppWebViewController wvcontroller, Uri? url) {
                    wvcontroller.getHtml().then((value) => {
                          controller.url.value = url.toString(),
                          controller.showConfirmationIfSuccess(),
                          controller.progress.value = 1,
                        });

                    // print(value),
                    // if (value!.contains(
                    //     "<html><head></head><body>true</body></html>"))
                    //   widget.onGet(true)
                    // else if (value.contains(
                    //     "<html><head></head><body>false</body></html>"))
                    //   widget.onGet(false)
                  },
                ),
              ),
            );
          }),
        ]));
  }
}
