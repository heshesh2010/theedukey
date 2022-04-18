import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoadingDialog() {


  showDialog(
      barrierDismissible: true,
      context: Get.key.currentState!.context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:  const Color.fromRGBO(22, 178, 178, 60),
          shape: const CircleBorder( ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
           Image.asset("assets/img/load3.gif",
             fit: BoxFit.cover,),
              const   Text(
                "جاري التحميل",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        );
      });
}
