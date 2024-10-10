import 'package:anbotofront/utils/app_style.dart';
import 'package:flutter/material.dart';


class CustomTextFormFieldWidget extends StatefulWidget {
  const CustomTextFormFieldWidget({
    super.key,
    required this.hintText,
    this.labelText,
    this.controller,
    this.obscureText,
    this.validator,
    this.suffixFocusedIcon,
    this.suffixIcon,
    this.textInputType,
    this.onChanged,
  });

  final TextEditingController? controller;
  final bool? obscureText;
  final String hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final Widget? suffixFocusedIcon;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final void Function(String)? onChanged;

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  bool? _currentObscureText;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _currentObscureText = widget.obscureText;
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _currentObscureText ?? false,
      focusNode: _focusNode,
      keyboardType: widget.textInputType,
      onChanged: widget.onChanged,
      maxLength: widget.textInputType == TextInputType.phone ? 11 : null,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff050522)),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: const Color(0xff050522).withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: widget.hintText,
        hintStyle:
            AppStyle.styleRegular18.copyWith(color: const Color(0xff000000)),
        label: Text(
          widget.labelText ?? widget.hintText,
          style: _getLabelStyle(),
        ),
        errorMaxLines: 3,
        counterText: '',
        suffixIcon: _getSuffixIcon(),
      ),
    );
  }

  TextStyle _getLabelStyle() {
    return _isFocused
        ? AppStyle.styleRegular15
        : AppStyle.styleRegular18
            .copyWith(color: const Color(0xff050522).withOpacity(0.5));
  }

  Widget? _getSuffixIcon() {
    return _isFocused
        ? (widget.obscureText != null
            ? IconButton(
                icon: Icon(
                  _currentObscureText!
                      ? Icons.lock_outline
                      : Icons.lock_open_outlined,
                ),
                onPressed: () {
                  setState(() {
                    _currentObscureText = !_currentObscureText!;
                  });
                })
            : widget.suffixFocusedIcon)
        : (widget.obscureText != null
            ? IconButton(
                icon: Icon(
                  _currentObscureText!
                      ? Icons.lock_outline
                      : Icons.lock_open_outlined,
                  color: const Color(0xffA0936B),
                ),
                onPressed: () {
                  setState(() {
                    _currentObscureText = !_currentObscureText!;
                  });
                })
            : widget.suffixIcon);
  }
}
