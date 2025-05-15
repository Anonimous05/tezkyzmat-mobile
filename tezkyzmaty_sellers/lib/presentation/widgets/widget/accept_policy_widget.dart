import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';

class AcceptPolicyWidget extends StatelessWidget {
  const AcceptPolicyWidget({
    super.key,
    required this.isAccept,
    required this.onChanged,
  });
  final bool isAccept;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return TezMotion(
      onPressed: () {
        onChanged(!isAccept);
      },
      child: Row(
        children: [
          SvgPicture.asset(
            isAccept ? SVGConstant.icCheckOn : SVGConstant.icCheckOff,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              LocaleKeys.acceptPolicy.tr(),
              style: FontConstant.bodySmallTextStyleFont(color: TezColor.black),
            ),
          ),
        ],
      ),
    );
  }
}
