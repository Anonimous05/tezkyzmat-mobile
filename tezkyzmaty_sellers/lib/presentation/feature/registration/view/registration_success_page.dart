import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/router/router_path.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/container_radio_button.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_button.dart';

class RegistrationSuccessPage extends StatefulWidget {
  const RegistrationSuccessPage({super.key});

  @override
  State<RegistrationSuccessPage> createState() =>
      _RegistrationSuccessPageState();
}

class _RegistrationSuccessPageState extends State<RegistrationSuccessPage> {
  int? selectedType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TezColor.black.withValues(alpha: 0.35),
        elevation: 0,
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 64.h),
                Center(child: Image.asset(ImageConstant.success)),
                SizedBox(height: 24.h),
                Text(
                  tr(LocaleKeys.success),
                  style: FontConstant.headingSmallTextStyleFont(
                    color: TezColor.black,
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Container(color: TezColor.black.withValues(alpha: 0.35)),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: TezColor.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      tr(LocaleKeys.typeOfActivity),
                      style: FontConstant.headingSmallTextStyleFont(
                        color: TezColor.black,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    ContainerRadioButton(
                      isSelected: selectedType == 1,
                      text: tr(LocaleKeys.sellParts),
                      onTap: (p0) {
                        setState(() {
                          selectedType = 1;
                        });
                      },
                    ),
                    SizedBox(height: 8.h),
                    ContainerRadioButton(
                      isSelected: selectedType == 2,
                      text: tr(LocaleKeys.provideServices),
                      onTap: (p0) {
                        setState(() {
                          selectedType = 2;
                        });
                      },
                    ),
                    SizedBox(height: 61.h),
                    CustomButton(
                      width: double.infinity,
                      isEnable: selectedType != null,
                      padding: EdgeInsets.symmetric(
                        vertical: 18.h,
                        horizontal: 24.w,
                      ),
                      title: LocaleKeys.next,
                      onPressed: () {
                        if (selectedType != null) {
                          if (selectedType == 1) {
                            context.pushNamed(RouterPath.registrationSellParts);
                          } else {
                            context.pushNamed(RouterPath.registrationService);
                          }
                          // context.pushNamed(RouterPath.registrationSuccess);
                          // authorizationCubit.login(
                          //   numberCont.text
                          //       .trim()
                          //       .replaceAll(' ', '')
                          //       .replaceAll('+', ''),
                          //   passwordCont.text.trim(),
                          // );
                        }
                      },
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
