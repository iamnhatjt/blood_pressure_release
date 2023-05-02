import 'package:flutter/material.dart';

import '../theme/app_color.dart';

class AppLoading extends StatelessWidget {
  final Color? color;
  const AppLoading({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: Colors.black.withOpacity(0.4),
      child: Center(
        child: CircularProgressIndicator(
          color: color ?? AppColor.secondaryColor,
        ),
      ),
    );
  }
}
