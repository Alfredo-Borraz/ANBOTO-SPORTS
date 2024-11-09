import 'package:anbotofront/helper/show_snack.dart';
import 'package:anbotofront/services/usuario_service.dart';
import 'package:anbotofront/utils/validations.dart';
import 'package:anbotofront/widgets/custom_elevated_button_widget.dart';
import 'package:anbotofront/widgets/custom_text_form_field_widget.dart';
import 'package:flutter/material.dart';

class CreateAccountFormWidget extends StatefulWidget {
  const CreateAccountFormWidget({super.key});

  @override
  State<CreateAccountFormWidget> createState() =>
      _CreateAccountFormWidgetState();
}

class _CreateAccountFormWidgetState extends State<CreateAccountFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final UsuarioService usuarioService = UsuarioService();

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text.trim();
      String email = _emailController.text.trim();
      String phone = _phoneController.text.trim();
      String password = _passwordController.text.trim();

      String? message =
          await usuarioService.register(username, email, phone, password);
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
            labelText: "Nombre de Usuario",
            hintText: "Nombre de usuario",
            controller: _usernameController,
          ),
          const SizedBox(height: 20),
          CustomTextFormFieldWidget(
            labelText: "Correo Electrónico",
            hintText: "info@example.com",
            controller: _emailController,
            validator: Validations.validateEmailOrUsername,
          ),
          const SizedBox(height: 20),
          CustomTextFormFieldWidget(
            labelText: "Teléfono",
            hintText: "+52 1234567890",
            controller: _phoneController,
          ),
          const SizedBox(height: 20),
          CustomTextFormFieldWidget(
            labelText: "Contraseña",
            hintText: "Ingresa tu contraseña",
            controller: _passwordController,
            obscureText: true,
            validator: Validations.validatePassword,
          ),
          const SizedBox(height: 20),
          CustomTextFormFieldWidget(
            labelText: "Confirma tu contraseña",
            hintText: "Ingresa tu contraseña",
            controller: _confirmPasswordController,
            obscureText: true,
            validator: (value) {
              return Validations.validateConfirmPassword(
                  value, _passwordController.text);
            },
          ),
          const SizedBox(height: 20),
          CustomElevatedButtonWidget(
            buttonText: "Registro",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context);
                _register();
                showSnackBar(context, "Create Account Success");
              } else {
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
