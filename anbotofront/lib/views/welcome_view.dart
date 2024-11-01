import 'package:anbotofront/utils/app_style.dart';
import 'package:anbotofront/widgets/welcome_action_button_widget.dart';
import 'package:anbotofront/widgets/welcome_widget.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff050522),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WelcomeWidget(),
            SizedBox(
              height: 60,
            ),
            WelcomActionButtonWidget(),
            SizedBox(
              height: 36,
            ),
            Text(
              "All Right Reserved @2024",
              style: AppStyle.styleRegular11,
            )
          ],
        ),
      ),
    );
  }
}
