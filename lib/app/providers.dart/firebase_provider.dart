/*
 * File name: firebase_provider.dart
 * Last modified: 2022.08.18 at 20:21:33
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:get/get.dart';

import '../services/auth_service.dart';

class FirebaseProvider extends GetxService {
  final fba.FirebaseAuth _auth = fba.FirebaseAuth.instance;

  Future<FirebaseProvider> init() async {
    return this;
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      fba.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return await signUpWithEmailAndPassword(email, password);
    }
  }

  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    fba.UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (result.user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> verifyPhone(String smsCode) async {
    try {
      final fba.AuthCredential credential = fba.PhoneAuthProvider.credential(
          verificationId:
              Get.find<AuthService>().user.value.verificationId ?? "",
          smsCode: smsCode);

      await fba.FirebaseAuth.instance.signInWithCredential(credential);
      Get.find<AuthService>().user.value.verifiedPhone = 1;
    } on fba.FirebaseAuthException catch (authException) {
      Get.find<AuthService>().user.value.verifiedPhone = 0;
      if (authException.code == 'invalid-phone-number') {
        throw Exception('invalid_phone_number'.tr);
      } else if (authException.code == 'invalid-verification-code') {
        throw Exception('invalid_verification_code'.tr);
      } else if (authException.code == 'invalid-credential') {
        throw Exception('invalid_credential'.tr);
      } else if (authException.code == "session-expired") {
        throw Exception('session_expired'.tr);
      } else {
        throw Exception(authException);
      }
    }
  }

  Future<void> sendCodeToPhone() async {
    Get.find<AuthService>().user.value.verificationId = '';

    autoRetrieve(String verId) {}
    smsCodeSent(String verId, [int? forceCodeResent]) {
      Get.find<AuthService>().user.value.verificationId = verId;
    }

    verifiedSuccess(fba.AuthCredential auth) async {}

    verifyFailed(fba.FirebaseAuthException authException) {
      if (authException.code == 'invalid-phone-number') {
        throw Exception('invalid_phone_number'.tr);
      } else if (authException.code == 'invalid-verification-code') {
        throw Exception('invalid_verification_code'.tr);
      } else if (authException.code == 'invalid-credential') {
        throw Exception('invalid_credential'.tr);
      } else {
        throw Exception(authException.message);
      }
    }

    await _auth.verifyPhoneNumber(
      phoneNumber: Get.find<AuthService>().user.value.phone,
      timeout: const Duration(seconds: 30),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  Future signOut() async {
    return await _auth.signOut();
  }

  Future<void> deleteCurrentUser() async {
    return await _auth.currentUser?.delete();
  }
}
