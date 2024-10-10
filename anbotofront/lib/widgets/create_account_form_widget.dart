import 'package:anbotofront/helper/show_snack.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _courseController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomTextFormFieldWidget(
            labelText: "username/email",
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
            labelText: "course",
            hintText: "course name",
            controller: _courseController,
            validator: Validations.validateString,
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
            labelText: "password",
            hintText: "write strong password",
            controller: _passwordController,
            obscureText: true,
            validator: Validations.validatePassword,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormFieldWidget(
            labelText: "confirm password",
            hintText: "write password again",
            controller: _confirmPasswordController,
            obscureText: true,
            validator: (value) {
              return Validations.validateConfirmPassword(
                  value, _passwordController.text);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomElevatedButtonWidget(
            buttonText: "Register",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context);
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
