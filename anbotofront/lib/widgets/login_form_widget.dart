import 'package:anbotofront/helper/show_snack.dart';
import 'package:anbotofront/services/usuario_service.dart';
import 'package:anbotofront/torneos/screens/menu_torneo.dart';
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
  final UsuarioService usuarioService = UsuarioService();

  Future<void> _login() async {
    if (!isChecked) {
      setState(() {
        isValidateCheckbox = true;
      });
      return;
    }

    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      String? message = await usuarioService.login(email, password);
      print("Resultado del login: $message");

      if (message == 'Inicio de sesión exitoso') {
        showSnackBar(context, message ?? 'Inicio de sesion exitoso');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuTorneo()),
        );
      } else {
        showSnackBar(context, message ?? "Error al iniciar sesión");
      }
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomTextFormFieldWidget(
            labelText: "Correo Electrónico",
            hintText: "info@example.com",
            controller: _emailController,
            validator: Validations.validateEmailOrUsername,
          ),
          const SizedBox(height: 20),
          CustomTextFormFieldWidget(
            labelText: "Contraseña",
            hintText: "Escribe tu contraseña",
            controller: _passwordController,
            obscureText: true,
            validator: Validations.validatePassword,
          ),
          const SizedBox(height: 20),
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
              const Text('¿Se te olvidó la contraseña?'),
            ],
          ),
          CustomElevatedButtonWidget(
            buttonText: "Login",
            onPressed: _login,
            borderColor: const Color(0xff050522),
            width: 325,
          ),
        ],
      ),
    );
  }
}
