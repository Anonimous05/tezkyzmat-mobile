import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(
            indent: 0.0,
            endIndent: 30.0,
            thickness: 1,
            color: TezColor.surfaceSecondaryHover,
          ),
        ),
        Text(
          tr(text),
          style: FontConstant.bodyLargeTextStyleFont(color: TezColor.textBody),
        ),
        const Expanded(
          child: Divider(
            indent: 30.0,
            endIndent: 0.0,
            thickness: 1,
            color: TezColor.surfaceSecondaryHover,
          ),
        ),
      ],
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black12, Colors.black38, Colors.black12],
        ),
      ),
    );
  }
}
