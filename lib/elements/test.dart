import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;
import 'package:get/get.dart';

class DemoBody extends StatefulWidget {
  const DemoBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DemoBodyState();
  }
}

class _DemoBodyState extends State<DemoBody> with TickerProviderStateMixin {
  late AnimationController animationController;
  List<Offset> animList1 = [];
  List<Offset> animList2 = [];

  final int xOffset = 50;
  final int yOffset = 10;
  final Color? color = Colors.red;
  late Size size;
  @override
  void initState() {
    super.initState();
    size = Size(Get.size.width, 200.0);
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animationController.addListener(() {
      animList1.clear();
      for (int i = -2 - xOffset; i <= size.width.toInt() + 2; i++) {
        animList1.add(Offset(
            i.toDouble() + xOffset,
            sin((animationController.value * 360 - i) %
                        360 *
                        vector.degrees2Radians) *
                    20 +
                50 +
                yOffset));
      }
      animList2.clear();
      for (int i = -2 - xOffset; i <= size.width.toInt() + 2; i++) {
        animList2.add(Offset(
            i.toDouble() + xOffset,
            sin((animationController.value * 360 - i) %
                        360 *
                        vector.degrees2Radians) *
                    20 +
                50 +
                yOffset));
      }
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        builder: (context, child) => ClipPath(
          clipper: WaveClipper(animationController.value, animList1, animList2),
          child: color != null
              ? Image.asset(
                  'assets/img/header_bg.png',
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: size.width,
                  height: size.height,
                  color: color,
                ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList1 = [];
  List<Offset> waveList2 = [];

  WaveClipper(this.animation, this.waveList1, this.waveList2);

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.addPolygon(waveList1, false);
    //path.addPolygon(waveList2, false);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}
