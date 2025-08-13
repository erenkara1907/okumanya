import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resource/styles/app_colors.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.textEditingController,
    this.borderColor,
    this.hintText,
    this.labelText,
    this.maxLines,
    this.obsureText,
    this.validator,
    this.onChanged,
    this.onTap,
    this.inputFormatters,
    this.borderRadius,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputType,
    this.readOnly,
  });

  final TextEditingController textEditingController;
  final Color? borderColor;
  final String? hintText;
  final String? labelText;
  final int? maxLines;
  final bool? obsureText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final double? borderRadius;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? textInputType;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly ?? false,
      autofocus: false,
      inputFormatters: inputFormatters ?? [],
      keyboardType: textInputType ?? TextInputType.multiline,
      controller: textEditingController,
      validator: validator,
      maxLines: maxLines ?? 1,
      autocorrect: false,
      style: Theme.of(context).textTheme.bodyMedium,
      obscureText: obsureText ?? false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          borderSide: BorderSide(
            color: borderColor ??
                AppColors.defaultAppColor.primaryTextColor.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          borderSide: BorderSide(
            color: borderColor ??
                AppColors.defaultAppColor.primaryTextColor.withOpacity(0.5),
          ),
        ),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color:
                  AppColors.defaultAppColor.primaryTextColor.withOpacity(0.5),
            ),
        label: labelText != null ? Text(labelText!) : null,
        fillColor: Colors.white,
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}