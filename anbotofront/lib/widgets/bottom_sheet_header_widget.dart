import 'package:anbotofront/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class BottomSheetHeaderWidget extends StatelessWidget {
  const BottomSheetHeaderWidget({
    super.key,
    required this.massegeTitle,
    required this.nameSubTitle,
  });

  final String massegeTitle;
  final String nameSubTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        massegeTitle,
        style: AppStyle.styleRegular20,
      ),
      subtitle: Text(
        nameSubTitle,
        style: AppStyle.styleBold30,
      ),
      trailing: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: SvgPicture.asset(
          "assets/images/close_icon.svg",
          width: 30.0,
        ),
      ),
    );
  }
}
