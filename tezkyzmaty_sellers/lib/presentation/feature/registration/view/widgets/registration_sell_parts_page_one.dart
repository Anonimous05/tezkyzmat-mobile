import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezkyzmaty_sellers/core/constants/general_limit_constant.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_input_field.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dropdown_custom.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/input_variable.dart';

class RegistrationSellPartsPageOne extends StatelessWidget {
  const RegistrationSellPartsPageOne({
    super.key,
    required this.nameOfLegalEntityController,
    required this.innController,
    this.selectedRegistrationType,
    this.selectedNdsType,
    required this.registrationType,
    required this.ndsType,
    required this.onChangedRegistrationType,
    required this.onChangedNdsType,
    required this.onChanged,
  });

  final TextEditingController nameOfLegalEntityController;
  final TextEditingController innController;
  final String? selectedRegistrationType;
  final String? selectedNdsType;
  final List<String> registrationType;
  final List<String> ndsType;
  final Function(String) onChangedRegistrationType;
  final Function(String) onChangedNdsType;
  final Function() onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            DropdownCustomTez<String>(
              hintText: LocaleKeys.formOfRegistration,
              items: registrationType,
              selectedItem: selectedRegistrationType,
              isRequired: true,
              onChanged: (value) {
                onChangedRegistrationType(value);
              },
              itemT: LocaleKeys.formOfRegistration,
            ),
            SizedBox(height: 22.h),
            const RowTitle(text: LocaleKeys.nameOfLegalEntity),
            SizedBox(height: 6.h),
            CustomInputField(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 13.h,
              ),

              onChange: (p0) {
                onChanged();
              },
              maxLength: GeneralLimitConstant.legalEntityMaxLimit,
              fillColor: TezColor.backgroundPrimary,
              controller: nameOfLegalEntityController,
              hintText: tr(LocaleKeys.nameOfLegalEntityPlaceholder),
            ),
            SizedBox(height: 22.h),
            const RowTitle(text: LocaleKeys.inn),
            SizedBox(height: 6.h),
            CustomInputField(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 13.h,
              ),

              onChange: (p0) {
                onChanged();
              },

              maxLength: GeneralLimitConstant.innLimit,
              fillColor: TezColor.backgroundPrimary,
              controller: innController,
              isDigit: true,
              hintText: tr(LocaleKeys.inn),
            ),
            SizedBox(height: 22.h),
            DropdownCustomTez<String>(
              hintText: LocaleKeys.statusOfNDS,
              items: ndsType,
              selectedItem: selectedNdsType,
              onChanged: (value) {
                onChangedNdsType(value);
              },
              itemT: LocaleKeys.statusOfNDS,
            ),
          ],
        ),
      ),
    );
  }
}
