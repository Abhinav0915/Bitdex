import 'package:bitdex/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:bitdex/screens/homepage.dart';
import 'package:bitdex/constants/appcolors.dart';
import 'package:lottie/lottie.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Lottie.network(
                  "https://assets2.lottiefiles.com/packages/lf20_DV5KsPrQIn.json",
                  controller: _controller,
                  // fit: BoxFit.cover,
                  onLoaded: (compos) {
                    _controller
                      ..duration = compos.duration
                      ..forward().then((value) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => login()));
                      });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
