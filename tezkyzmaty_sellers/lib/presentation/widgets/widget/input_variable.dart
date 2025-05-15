// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_input_field.dart';

class RowTitle extends StatelessWidget {
  const RowTitle({
    super.key,
    required this.text,
    this.isReq = false,
    this.isMedium = false,
    this.isLarge = false,
    this.isOptional = false,
    this.isGray = false,
  });
  final String text;
  final bool isReq;
  final bool isLarge;
  final bool isMedium;
  final bool isOptional;
  final bool isGray;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style:
              isLarge
                  ? FontConstant.labelMediumSemiTextStyleFont(
                    color: TezColor.textHeading,
                  )
                  : isMedium
                  ? FontConstant.labelSmallSemiTextStyleFont(
                    color: TezColor.textHeading,
                  )
                  : FontConstant.bodyMediumTextStyleFont(
                    color: isGray ? TezColor.black50 : TezColor.black,
                  ),
        ).tr(),
        if (isReq) const ReqText(),
      ],
    );
  }
}

class ReqText extends StatelessWidget {
  const ReqText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.r),
      child: Text(
        '*',
        style: FontConstant.bodySmallSemiTextStyleFont(color: TezColor.error),
      ),
    );
  }
}

class RowTitleWithInput extends StatelessWidget {
  const RowTitleWithInput({
    super.key,
    required this.text,
    this.isReq = false,
    this.isOptional = false,
    required this.controller,
    required this.onChanged,
    this.isDigit = false,
    this.maxLines,
    this.minLines,
  });
  final String text;
  final bool isReq;
  final int? minLines;

  final int? maxLines;
  final bool isOptional;
  final bool isDigit;
  final TextEditingController controller;
  final Function() onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RowTitle(text: text, isReq: isReq, isOptional: isOptional),
        SizedBox(height: 8.h),
        CustomInputField(
          minLines: minLines,
          maxLines: maxLines,
          height: maxLines == null ? null : 40,
          isDigit: isDigit,
          onPressed: () {},
          hintStyle: FontConstant.bodyMediumTextStyleFont(
            color: TezColor.gray300,
          ),
          textStyle: FontConstant.bodyMediumTextStyleFont(
            color: TezColor.textHeading,
          ),
          fillColor: Colors.white,
          controller: controller,
          onChange: (p0) {
            onChanged();
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          hintText: tr(text),
          borderRadius: 4,
        ),
      ],
    );
  }
}
