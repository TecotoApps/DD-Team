import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCurvedEdges extends StatelessWidget {
  final TextEditingController controller;
  final Color backgroundColor;
  final TextInputType keyboardType;
  final Color borderColor;
  final double borderRadius;
  final TextAlign textAlign;
  final int length;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final String? inputFormatter;
  final String? validatorType;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;

  const TextFieldCurvedEdges({
    Key? key,
    required this.controller,
    required this.backgroundColor,
    required this.keyboardType,
    required this.borderColor,
    this.borderRadius = 20.0,
    this.textAlign = TextAlign.start,
    this.length = 100,
    this.focusNode,
    this.onSubmitted,
    this.onChanged,
    this.inputFormatter = '',
    this.validatorType = '',
    this.readOnly = false,
    this.onTap,
    this.hintText,
    this.labelText,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextFormField(
          style: AppFonts.title.copyWith(
            color: AppColors.textColor,
            fontWeight: FontWeight.w500,
          ),
          controller: controller,
          cursorColor: AppColors.textColor,
          keyboardType: keyboardType,
          textAlign: textAlign,
          maxLength: length,
          maxLines: 1,
          focusNode: focusNode,
          readOnly: readOnly,
          onTap: onTap,
          onFieldSubmitted: onSubmitted,
          onChanged: onChanged,
          inputFormatters: inputFormatter == 'number'
              ? <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[\d+]')),
          ]
              : [],
          validator: validatorType == 'phone'
              ? (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a mobile number';
            }
            if (!RegExp(r'^(0/+91)?[6-9]\d{1}[0-9]\d{9}$')
                .hasMatch(value)) {
              return 'Please enter a valid 10-digit mobile number';
            }
            return null;
          }
              : null,
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: '',
            hintText: hintText,
            labelText: labelText,
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
