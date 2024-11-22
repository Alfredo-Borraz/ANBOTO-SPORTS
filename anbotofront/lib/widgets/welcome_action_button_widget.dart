import 'package:anbotofront/helper/view_button_helper_sheet.dart';
import 'package:anbotofront/widgets/create_account_bottom_shet_body_widget.dart';
import 'package:anbotofront/widgets/custom_elevated_button_widget.dart';
import 'package:anbotofront/widgets/login_bottom_sheet_body_widget.dart';
import 'package:flutter/material.dart';

class WelcomActionButtonWidget extends StatelessWidget {
  const WelcomActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButtonWidget(
          buttonText: "Registrate",
          onPressed: () {
            viewBottomSheet(
                context, const CreateAccountBottomSheetBodyWidget());
          },
          backgroundColor: const Color(0xffFFDE69),
          textColor: const Color(0xff1B1A40),
        ),
        const SizedBox(
          height: 15,
        ),
        CustomElevatedButtonWidget(
          buttonText: "Iniciar Sesion",
          onPressed: () {
            viewBottomSheet(context, const LoginBottomSheetBodyWidget());
          },
        )
      ],
    );
  }
}
