import 'package:anbotofront/utils/app_style.dart';
import 'package:flutter/material.dart';


class CustomElevatedButtonWidget extends StatelessWidget {
  const CustomElevatedButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.textColor,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor,
  });

  final String buttonText;
  final void Function()? onPressed;
  final Color? textColor;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        fixedSize: Size(width ?? 281, height ?? 60),
        backgroundColor: backgroundColor ?? const Color(0xff050522),
        side:
            BorderSide(color: borderColor ?? const Color(0xffFFDE69), width: 3),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: AppStyle.styleSemibold20.copyWith(color: textColor),
      ),
    );
  }
}
