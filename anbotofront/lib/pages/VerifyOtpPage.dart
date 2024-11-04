import 'package:anbotofront/helper/show_snack.dart';
import 'package:anbotofront/services/usuario_service.dart';
import 'package:anbotofront/widgets/custom_elevated_button_widget.dart';
import 'package:anbotofront/widgets/custom_text_form_field_widget.dart';
import 'package:flutter/material.dart';

class VerifyOtpPage extends StatefulWidget {
  final String username;

  const VerifyOtpPage({Key? key, required this.username}) : super(key: key);

  @override
  _VerifyOtpPageState createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final _otpController = TextEditingController();
  final UsuarioService usuarioService = UsuarioService();

  Future<void> _verifyOTP() async {
    String otp = _otpController.text.trim();
    bool success = await usuarioService.verifyOTP(widget.username, otp);

    if (success) {
      showSnackBar(context, "Verificación exitosa");
      Navigator.pop(context);
    } else {
      showSnackBar(context, "OTP inválido o expirado");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verificar OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextFormFieldWidget(
              labelText: "OTP",
              hintText: "Ingresa el OTP",
              controller: _otpController,
            ),
            const SizedBox(height: 20),
            CustomElevatedButtonWidget(
              buttonText: "Verificar",
              onPressed: _verifyOTP,
              borderColor: const Color(0xff050522),
              width: 325,
            ),
          ],
        ),
      ),
    );
  }
}
