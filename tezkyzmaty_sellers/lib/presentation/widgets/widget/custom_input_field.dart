import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.notBorderColor,
    this.autofocus = false,
    this.textInputType = TextInputType.text,
    this.prefix,
    this.focusNode,
    this.validator,
    this.textInputAction,
    this.adviceText,
    this.inputFormatter,
    this.onChange,
    this.onSubmit,
    this.onPressed,
    this.enabled,
    this.readOnly,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength = 1000,
    this.height = 40,
    this.textAlignVertical = TextAlignVertical.center,
    this.maxLines = 1,
    this.minLines = 1,
    this.textAlign = TextAlign.start,
    this.borderRadius = 10,
    this.textColor = TezColor.textHeading,
    this.borderColor = TezColor.borderPrimary,
    this.fillColor = TezColor.cF5F5F7,
    this.contentPadding,
    this.isDigit = false,
    this.isDouble = false,
    this.isPassword = false,
    this.isUnderline = false,
    this.hintStyle,
    this.textStyle,
    this.isFlag = false,
    this.flagImage,
    this.textCapitalization = TextCapitalization.sentences,
  });

  final FocusNode? focusNode;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? prefix;
  final String hintText;
  final String? adviceText;
  final bool? enabled;
  final double borderRadius;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatter;
  final Function(String?)? validator;
  final Function(String)? onChange;
  final Function(String)? onSubmit;

  final Function()? onPressed;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool autofocus;
  final bool? notBorderColor;
  final int maxLength;
  final double? height;
  final TextAlignVertical textAlignVertical;
  final int? maxLines;
  final int? minLines;

  final TextAlign textAlign;
  final Color textColor;
  final Color borderColor;
  final Color fillColor;
  final EdgeInsets? contentPadding;
  final bool isDigit;
  final bool isDouble;
  final bool isPassword;
  final bool isUnderline;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final bool isFlag;
  final String? flagImage;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      onSubmitted: (value) {
        if (onSubmit != null) {
          onSubmit!(value);
        }
      },
      obscureText: isPassword,
      textAlign: textAlign,
      textAlignVertical: TextAlignVertical.center,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      enabled: enabled,
      readOnly: readOnly ?? false,
      cursorColor: Colors.black,
      autofocus: autofocus,
      style: textStyle ?? FontConstant.bodyLargeTextStyleFont(color: textColor),
      controller: controller,
      focusNode: focusNode,
      keyboardType:
          isDigit
              ? TextInputType.numberWithOptions(decimal: isDouble)
              : textInputType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      inputFormatters:
          inputFormatter ??
          <TextInputFormatter>[
            if (isDigit && !isDouble) FilteringTextInputFormatter.digitsOnly,
            // if (isDigit || isDouble) ThousandSeparatorInputFormatter(),
            if (isDouble)
              TextInputFormatter.withFunction((oldValue, newValue) {
                return newValue.copyWith(
                  text: newValue.text.replaceAll(RegExp(r'\,'), '.'),
                );
              }),
          ],
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        counterText: '',
        isDense: true,
        hintText: hintText,
        hintMaxLines: 3,
        contentPadding:
            contentPadding ??
            EdgeInsets.only(top: 18.h, bottom: 18.h, left: 16.w, right: 16.w),
        hintStyle:
            hintStyle ??
            FontConstant.bodyLargeTextStyleFont(
              color: TezColor.black.withAlpha(125),
            ),
        focusedBorder:
            isUnderline
                ? UnderlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                )
                : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius.r),
                  borderSide: BorderSide(
                    color:
                        validator?.call(controller.text) == null
                            ? borderColor
                            : TezColor.borderError,
                  ),
                ),
        enabledBorder:
            isUnderline
                ? UnderlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                )
                : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide(
                    color:
                        validator?.call(controller.text) == null
                            ? borderColor
                            : TezColor.error,
                  ),
                ),
        border:
            isUnderline
                ? UnderlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                )
                : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide(color: borderColor),
                ),
        disabledBorder:
            isUnderline
                ? UnderlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                )
                : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide(color: borderColor),
                ),
        focusedErrorBorder:
            isUnderline
                ? UnderlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                )
                : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: const BorderSide(color: TezColor.borderError),
                ),
        prefixIcon:
            isFlag
                ? SizedBox(
                  height: 24.h,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 10.w),

                      Image.asset(
                        flagImage ?? ImageConstant.flagKG,
                        height: 21.h,
                        width: 30.w,
                      ),
                      SizedBox(width: 10.w),
                      SizedBox(
                        height: 24.h,
                        width: 1.w,
                        child: const VerticalDivider(
                          color: TezColor.dividerColor,
                        ),
                      ),
                      SizedBox(width: 10.w),
                    ],
                  ),
                )
                : prefixIcon,
        suffixIcon: suffixIcon,
      ),
      onChanged: (value) {
        // setState(() {
        //   validator?.call(
        //     controller.text,
        //   );
        // });

        onChange?.call(controller.text);
      },
    );
  }
}

class ThousandSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat('#,###');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final String formatted = _formatter.format(int.parse(newText));

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
