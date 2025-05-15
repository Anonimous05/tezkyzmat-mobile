import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';

class TKRadioButton extends StatelessWidget {
  const TKRadioButton({required this.isCheck, super.key});
  final bool isCheck;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      width: 24.h,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: TezColor.borderPrimary),
      ),
      child:
          isCheck
              ? Container(
                height: 16.h,
                width: 16.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: TezColor.surfaceAction,
                ),
              )
              : null,
    );
  }
}
