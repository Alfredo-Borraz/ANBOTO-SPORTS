import 'package:anbotofront/utils/app_style.dart';
import 'package:flutter/material.dart';


class BottomSheetFooterWidget extends StatelessWidget {
  const BottomSheetFooterWidget({
    super.key,
    required this.actionText,
    required this.messageText,
    required this.onTap,
  });

  final String messageText;
  final String actionText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          messageText,
          style: AppStyle.styleRegular18.copyWith(
            color: const Color(0xff050522),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: AppStyle.styleSemibold20.copyWith(
              fontSize: 18,
              color: const Color(0xffEF5858),
            ),
          ),
        ),
      ],
    );
  }
}
