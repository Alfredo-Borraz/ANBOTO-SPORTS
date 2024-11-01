import 'package:anbotofront/helper/view_button_helper_sheet.dart';
import 'package:anbotofront/widgets/bottom_sheet_header_widget.dart';
import 'package:anbotofront/widgets/buttom_sheet_footer_widget.dart';
import 'package:anbotofront/widgets/create_account_bottom_shet_body_widget.dart';
import 'package:anbotofront/widgets/login_form_widget.dart';
import 'package:flutter/material.dart';


class LoginBottomSheetBodyWidget extends StatelessWidget {
  const LoginBottomSheetBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const BottomSheetHeaderWidget(
              massegeTitle: "Bienvenido de nuevo",
              nameSubTitle: "Login",
            ),
            const SizedBox(
              height: 25,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: LoginFormWidget(),
            ),
            const SizedBox(
              height: 10,
            ),
            BottomSheetFooterWidget(
              messageText: "¿No tienes una cuenta? ",
              actionText: "Registrate",
              onTap: () {
                Navigator.pop(context);
                viewBottomSheet(
                    context, const CreateAccountBottomSheetBodyWidget());
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
