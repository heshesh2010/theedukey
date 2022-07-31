import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/school_details_controller.dart';

class SchoolDetailsView extends GetView<SchoolDetailsController> {
  const SchoolDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SchoolDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SchoolDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
