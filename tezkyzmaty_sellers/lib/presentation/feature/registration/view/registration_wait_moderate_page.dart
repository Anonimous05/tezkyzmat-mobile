import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/router/router_path.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_button.dart';

class RegistrationWaitModeratePage extends StatelessWidget {
  const RegistrationWaitModeratePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              SizedBox(height: 64.h),
              Center(child: Image.asset(ImageConstant.success)),
              SizedBox(height: 24.h),
              Text(
                tr(LocaleKeys.confirmation),
                textAlign: TextAlign.center,

                style: FontConstant.headingSmallTextStyleFont(
                  color: TezColor.black,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                tr(LocaleKeys.waitingForApproval),
                textAlign: TextAlign.center,
                style: FontConstant.bodyLargeTextStyleFont(
                  color: TezColor.black70,
                ),
              ),
              SizedBox(height: 40.h),
              CustomButton(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w),
                title: LocaleKeys.toHome,
                onPressed: () {
                  context.go(RouterPath.home);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
