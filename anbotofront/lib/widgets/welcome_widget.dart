import 'package:anbotofront/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
        child: SvgPicture.asset(
          "assets/images/logo_picture.svg",
          width: 400.0,
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      const Text(
        "¡Bienvenido!",
        style: AppStyle.styleRegular36,
      ),
      const SizedBox(
        height: 15,
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Text(
          "Hola usuario",
          style: AppStyle.styleLight20,
          textAlign: TextAlign.center,
        ),
      ),
    ]);
  }
}
