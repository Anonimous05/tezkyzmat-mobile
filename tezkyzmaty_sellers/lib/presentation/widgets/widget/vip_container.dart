import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';

class VipContainer extends StatelessWidget {
  const VipContainer({
    super.key,
    required this.tarrifImageColor,
    required this.tariffName,
  });

  final Color? tarrifImageColor;
  final String tariffName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: TezColor.baseContainer),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            SVGConstant.icCrown,
            width: 12.r,
            height: 12.r,
            colorFilter: ColorFilter.mode(
              tarrifImageColor ?? Colors.white,
              BlendMode.srcIn,
            ),
            fit: BoxFit.fill,
          ),
          SizedBox(width: 4.w),
          Text(
            tr(tariffName),
            style: FontConstant.bodyLargeTextStyleFont(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
