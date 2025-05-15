import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/router/router_path.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/base_scaffold.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_button.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/vip_container.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isBack: false,
      title: tr(LocaleKeys.analytics_title),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tr(LocaleKeys.analytics_analyticsIn),
                  style: FontConstant.headingSmallTextStyleFont(
                    color: TezColor.black,
                  ),
                ),
                SizedBox(width: 10.w),
                VipContainer(
                  tarrifImageColor: TezColor.activeTab,
                  tariffName: tr(LocaleKeys.tarrifs_vip),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              tr(LocaleKeys.analytics_description1),
              textAlign: TextAlign.center,
              style: FontConstant.bodyLargeTextStyleFont(
                color: TezColor.black70,
              ),
            ),
            SizedBox(height: 34.h),
            Image.asset(
              ImageConstant.vipAnalytics,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
            SizedBox(height: 14.h),
            CustomButton(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w),
              title: LocaleKeys.analytics_goToVip,
              onPressed: () {
                context.pushNamed(RouterPath.tariffs);
              },
            ),
          ],
        ),
      ),
    );
  }
}
