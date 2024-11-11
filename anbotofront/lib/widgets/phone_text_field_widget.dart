import 'package:anbotofront/utils/app_style.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class PhoneTextField extends StatefulWidget {
  const PhoneTextField({
    super.key,
    required this.phoneController,
    this.validator,
    this.onChanged,
  });

  final TextEditingController phoneController;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  String _selectedCountryCode = '20';
  String _selectedCountryFlag = 'eg';

  void _updatePhoneNumber(String phoneNumber) {
    final fullPhoneNumber = '+$_selectedCountryCode$phoneNumber';
    widget.onChanged?.call(fullPhoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: TextFormField(
        controller: widget.phoneController,
        decoration: appStyle('123 456-7890').copyWith(
          prefixIcon: GestureDetector(
            onTap: () {
              showCountryPicker(
                context: context,
                showPhoneCode: true,
                onSelect: (country) {
                  setState(() {
                    _selectedCountryCode = country.phoneCode;
                    _selectedCountryFlag = country.countryCode;
                    _updatePhoneNumber(widget.phoneController.text);
                  });
                },
                countryListTheme: CountryListThemeData(
                  backgroundColor: Colors.grey[900], 
                  flagSize: 25,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  bottomSheetHeight:
                      500,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  inputDecoration: InputDecoration(
                    labelText: 'Buscar',
                    hintText: 'Buscar país',
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1.0
                      )
                    )
                  ),   
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CountryFlag.fromCountryCode(
                    shape: const RoundedRectangle(7),
                    height: 24,
                    width: 24,
                    _selectedCountryFlag.toLowerCase(),
                  ),
                  Text(
                    '+$_selectedCountryCode',
                    style: AppStyle.font14GrayRegular
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Icon(
                    MdiIcons.chevronDown,
                    size: 25,
                    color: Color(0xFF7E7E7E),
                  ),
                ],
              ),
            ),
          ),
        ),
        keyboardType: TextInputType.phone,
        validator: (phone) {
          if (!_validePhoneNumber('+' + _selectedCountryCode + phone!)) {
            return 'Por favor ingrese su número';
          }
          return null;
        },
        onChanged: (value) {
          _updatePhoneNumber(value);
        },
      ),
    );
  }
}

bool _validePhoneNumber(String value) {
  print(value);
  final phoneNumber = PhoneNumber.parse(value);
  final isValid = phoneNumber.isValid(type: PhoneNumberType.mobile);
  print(isValid);
  return isValid;
}
