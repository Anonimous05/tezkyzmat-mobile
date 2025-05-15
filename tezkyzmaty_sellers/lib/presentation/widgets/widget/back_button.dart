import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';

class TKBackButton extends StatelessWidget {
  const TKBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TezMotion(
      onPressed: () {
        context.pop();
      },
      child: Container(
        height: 40.r,
        width: 40.r,
        decoration: const BoxDecoration(
          color: TezColor.backgroundPrimary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            SVGConstant.icBack,
            height: 24.h,
            width: 24.h,
          ),
        ),
      ),
    );
  }
}

class TKShareButton extends StatelessWidget {
  const TKShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TezMotion(
      onPressed: () {},
      child: Container(
        height: 40.r,
        width: 40.r,
        decoration: const BoxDecoration(
          color: TezColor.backgroundPrimary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            SVGConstant.icExport,
            height: 24.h,
            width: 24.h,
          ),
        ),
      ),
    );
  }
}
