import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';

class ContainerRadioButton extends StatelessWidget {
  const ContainerRadioButton({
    super.key,
    required this.isSelected,
    required this.text,
    required this.onTap,
  });

  final bool isSelected;
  final String text;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return TezMotion(
      onPressed: () => onTap(text),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.r,
            color: isSelected ? TezColor.borderActive : TezColor.borderPrimary,
          ),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: FontConstant.bodyLargeTextStyleFont(
                color: TezColor.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 16.r,
              color: TezColor.black,
            ),
          ],
        ),
      ),
    );
  }
}
