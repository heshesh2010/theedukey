import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EditProfileView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'EditProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
