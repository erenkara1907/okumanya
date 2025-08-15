import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/resources/styles/app_colors.dart';
import '../../utils/string_extensions.dart';
import '../../utils/validation_utils.dart';

enum TextFieldType {
  normal,
  email,
  phone,
  turkishId,
  name,
  currency,
  numeric,
}

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.textEditingController,
    this.borderColor,
    this.hintText,
    this.labelText,
    this.maxLines,
    this.obscureText,
    this.validator,
    this.onChanged,
    this.onTap,
    this.inputFormatters,
    this.borderRadius,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputType,
    this.readOnly,
    this.fieldType = TextFieldType.normal,
    this.autoValidate = false,
    this.locale = 'tr_TR',
  });

  final TextEditingController textEditingController;
  final Color? borderColor;
  final String? hintText;
  final String? labelText;
  final int? maxLines;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final double? borderRadius;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? textInputType;
  final bool? readOnly;
  final TextFieldType fieldType;
  final bool autoValidate;
  final String locale;

  List<TextInputFormatter> _getInputFormatters() {
    if (inputFormatters != null) return inputFormatters!;

    switch (fieldType) {
      case TextFieldType.phone:
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
          TextInputFormatter.withFunction((oldValue, newValue) {
            if (newValue.text.isEmpty) return newValue;
            return TextEditingValue(
              text: newValue.text.formatTurkishPhone(),
              selection: TextSelection.collapsed(
                  offset: newValue.text.formatTurkishPhone().length),
            );
          }),
        ];
      case TextFieldType.turkishId:
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
          TextInputFormatter.withFunction((oldValue, newValue) {
            if (newValue.text.isEmpty) return newValue;
            return TextEditingValue(
              text: newValue.text.formatTurkishId(),
              selection: TextSelection.collapsed(
                  offset: newValue.text.formatTurkishId().length),
            );
          }),
        ];
      case TextFieldType.name:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZçğıöşüÇĞIİÖŞÜ\s]')),
          TextInputFormatter.withFunction((oldValue, newValue) {
            if (newValue.text.isEmpty) return newValue;
            return TextEditingValue(
              text: newValue.text.toCapitalCase(),
              selection: TextSelection.collapsed(
                  offset: newValue.text.toCapitalCase().length),
            );
          }),
        ];
      case TextFieldType.currency:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
        ];
      case TextFieldType.numeric:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        ];
      default:
        return [];
    }
  }

  String? Function(String?)? _getValidator() {
    if (validator != null) return validator;
    if (!autoValidate) return null;

    switch (fieldType) {
      case TextFieldType.email:
        return (value) => ValidationUtils.validateEmail(value, locale: locale);
      case TextFieldType.phone:
        return (value) =>
            ValidationUtils.validateTurkishPhone(value, locale: locale);
      case TextFieldType.turkishId:
        return (value) =>
            ValidationUtils.validateTurkishId(value, locale: locale);
      case TextFieldType.name:
        return (value) => ValidationUtils.validateName(value, locale: locale);
      case TextFieldType.numeric:
        return (value) =>
            ValidationUtils.validateNumeric(value, locale: locale);
      default:
        return null;
    }
  }

  TextInputType _getKeyboardType() {
    if (textInputType != null) return textInputType!;

    switch (fieldType) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.phone:
        return TextInputType.phone;
      case TextFieldType.turkishId:
      case TextFieldType.numeric:
        return TextInputType.number;
      case TextFieldType.currency:
        return const TextInputType.numberWithOptions(decimal: true);
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly ?? false,
      autofocus: false,
      inputFormatters: _getInputFormatters(),
      keyboardType: _getKeyboardType(),
      controller: textEditingController,
      validator: _getValidator(),
      maxLines: maxLines ?? 1,
      autocorrect: fieldType == TextFieldType.name,
      style: const TextStyle(color: Colors.black),
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          borderSide: BorderSide(
            color: borderColor ??
                AppColors.defaultAppColor.primaryTextColor
                    .withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          borderSide: BorderSide(
            color: borderColor ??
                AppColors.defaultAppColor.primaryTextColor
                    .withValues(alpha: 0.5),
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        label: labelText != null ? Text(labelText!) : null,
        fillColor: Colors.white,
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
