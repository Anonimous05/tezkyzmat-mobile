import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/core/utils/common_utils.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/profile/cubit/profile_cubit.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/base_scaffold.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_button.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/text_diver.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/vip_container.dart';

class TariffsPage extends StatefulWidget {
  const TariffsPage({super.key});

  @override
  State<TariffsPage> createState() => _TariffsPageState();
}

class _TariffsPageState extends State<TariffsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.loading) {
          context.loaderOverlay.show();
        }
        if (state.status == ProfileStatus.failure) {
          context.loaderOverlay.hide();
        }

        if (state.status == ProfileStatus.success) {
          context.loaderOverlay.hide();
        }
        if (state.status == ProfileStatus.successUpdateName) {
          context.loaderOverlay.hide();

          CommonUtil.showSnackBar(context, tr(LocaleKeys.saved));
        }
      },
      builder: (context, state) {
        return BaseScaffold(
          title: tr(LocaleKeys.tarrifs_title),
          body: SingleChildScrollView(
            child: Column(
              children: [
                TariffItem(
                  backgroundColor: Colors.white,
                  isSelected: true,
                  isBasic: true,
                  tariffName: tr(LocaleKeys.tarrifs_basic),
                  tariffPrice: '0',
                  onPressed: () {},

                  tariffDescription: [
                    tr(LocaleKeys.tarrifs_basicDescription1),
                    tr(LocaleKeys.tarrifs_basicDescription2),
                  ],
                ),
                SizedBox(height: 12.h),
                TariffItem(
                  backgroundColor: TezColor.F8EEAC,
                  tarrifImageColor: TezColor.activeTab,
                  isSelected: false,
                  isBasic: false,
                  tariffName: tr(LocaleKeys.tarrifs_vip),
                  tariffPrice: '999',
                  onPressed: () {},
                  tariffDescription: [
                    tr(LocaleKeys.tarrifs_vipDescription1),
                    tr(LocaleKeys.tarrifs_vipDescription2),
                    tr(LocaleKeys.tarrifs_vipDescription3),
                  ],
                ),
                SizedBox(height: 12.h),
                TariffItem(
                  backgroundColor: Colors.transparent,
                  tarrifImageColor: TezColor.success,
                  isSelected: false,
                  isBasic: false,
                  textColor: TezColor.white,
                  tariffName: tr(LocaleKeys.tarrifs_premium),
                  tariffPrice: '2500',
                  onPressed: () {},
                  colors: const [TezColor.black1c, TezColor.black50],
                  tariffDescription: [
                    tr(LocaleKeys.tarrifs_premiumDescription1),
                    tr(LocaleKeys.tarrifs_premiumDescription2),
                    tr(LocaleKeys.tarrifs_premiumDescription3),
                    tr(LocaleKeys.tarrifs_premiumDescription4),
                  ],
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TariffItem extends StatelessWidget {
  const TariffItem({
    super.key,
    required this.isSelected,
    required this.isBasic,
    required this.tariffName,
    required this.tariffPrice,
    required this.tariffDescription,
    required this.backgroundColor,
    this.tarrifImageColor,
    this.textColor,
    this.expireText,
    this.onPressed,
    this.colors = const [],
  });
  final bool isSelected;
  final bool isBasic;
  final String tariffName;
  final String tariffPrice;
  final List<String> tariffDescription;
  final Color backgroundColor;
  final Color? tarrifImageColor;
  final Color? textColor;
  final String? expireText;
  final Function()? onPressed;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: colors.isNotEmpty ? null : backgroundColor,
        gradient:
            colors.isNotEmpty
                ? LinearGradient(
                  colors: colors,
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                )
                : null,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          if (isBasic)
            Row(
              children: [
                Text(
                  tr(tariffName),
                  style: FontConstant.titleMediumTextStyleFont(
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 7.w),
                if (isSelected)
                  SvgPicture.asset(
                    SVGConstant.icGreenCheck,
                    width: 20.r,
                    height: 20.r,
                  ),
                const Spacer(),
                Text(
                  '0',
                  style: FontConstant.bodyMediumTextStyleFont(
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  'C',
                  style: FontConstant.bodySmallUnderLineTextStyleFont(
                    color: TezColor.black50,
                  ),
                ),
                SizedBox(width: 5.w),

                Text(
                  tr(LocaleKeys.tarrifs_monthes),
                  style: FontConstant.bodySmallTextStyleFont(
                    color: TezColor.black50,
                  ),
                ),
              ],
            ),
          if (!isBasic)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VipContainer(
                      tarrifImageColor: tarrifImageColor,
                      tariffName: tariffName,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Text(
                          tariffPrice,
                          style: FontConstant.bodyMediumTextStyleFont(
                            color: textColor ?? Colors.black,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          'C',
                          style: FontConstant.bodySmallUnderLineTextStyleFont(
                            color: TezColor.black50,
                          ),
                        ),
                        SizedBox(width: 5.w),

                        Text(
                          tr(LocaleKeys.tarrifs_monthes),
                          style: FontConstant.bodySmallTextStyleFont(
                            color: TezColor.black50,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                CustomButton(
                  title: tr(LocaleKeys.tarrifs_chooseTariff),
                  isGradient: false,
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                    vertical: 10.h,
                  ),
                  backgroundColor: backgroundColor,
                  textColor: textColor ?? TezColor.black,
                  borderColor: textColor ?? TezColor.black,
                  isBorder: true,
                  onPressed: () {
                    onPressed?.call();
                  },
                ),
              ],
            ),
          SizedBox(height: 20.h),
          const CustomDivider(),
          SizedBox(height: 20.h),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return RowTextCheck(
                text: tariffDescription[index],
                textColor: textColor,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 12.h);
            },
            itemCount: tariffDescription.length,
          ),
        ],
      ),
    );
  }
}

class RowTextCheck extends StatelessWidget {
  const RowTextCheck({super.key, required this.text, this.textColor});
  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(SVGConstant.icYellowCheck, width: 24.r, height: 24.r),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: FontConstant.bodyMediumTextStyleFont(
              color: textColor ?? TezColor.black,
            ),
          ),
        ),
      ],
    );
  }
}
