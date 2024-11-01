import 'package:anbotofront/helper/show_snack.dart';
import 'package:anbotofront/utils/app_style.dart';
import 'package:anbotofront/utils/validations.dart';
import 'package:anbotofront/widgets/custom_elevated_button_widget.dart';
import 'package:anbotofront/widgets/custom_text_form_field_widget.dart';
import 'package:flutter/material.dart';


class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isChecked = false;
  bool isValidateCheckbox = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomTextFormFieldWidget(
            labelText: "Correo Electronico",
            hintText: "info@example.com",
            controller: _emailController,
            validator: Validations.validateEmailOrUsername,
            suffixFocusedIcon: const Icon(
              Icons.remove_red_eye_outlined,
              color: Color(0xff050522),
            ),
            suffixIcon: const Icon(
              Icons.remove_red_eye_outlined,
              color: Color(0xffA0936B),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormFieldWidget(
            labelText: "Contraseña",
            hintText: "Escribe tu contraseña",
            controller: _passwordController,
            obscureText: true,
            validator: Validations.validatePassword,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Text(
                'Recordar',
                style: (isValidateCheckbox && !isChecked)
                    ? AppStyle.styleRegular15
                        .copyWith(color: const Color(0xffb42921))
                    : AppStyle.styleRegular15,
              ),
              const Spacer(),
              const Text('¿Se te olvido la contraseña?'),
            ],
          ),
          CustomElevatedButtonWidget(
            buttonText: "Login",
            onPressed: () {
              if (isChecked && _formKey.currentState!.validate()) {
                Navigator.pop(context);
                showSnackBar(context, "Login Success");
              } else {
                isValidateCheckbox = true;
                autovalidateMode = AutovalidateMode.always;
                setState(() {});
              }
            },
            borderColor: const Color(0xff050522),
            width: 325,
          ),
        ],
      ),
    );
  }
}
