// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/constants/general_limit_constant.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/data/models/classifiers.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_input_field.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dropdown_custom.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/input_variable.dart';

class AddressWidgets extends StatelessWidget {
  const AddressWidgets({
    super.key,
    required this.addressInput,
    required this.onChanged,
    required this.onDelete,
    required this.index,
    required this.shopType,
    required this.onChangedShopType,
    required this.onChangedCityOrVillage,
    required this.onChangedRegion,
    required this.onChangedCityOrDistrict,
  });
  final AddressInput addressInput;
  final void Function() onChanged;
  final void Function(int) onDelete;
  final List<String> shopType;
  final void Function(String, int) onChangedShopType;
  final void Function(CityVillage, int) onChangedCityOrVillage;
  final void Function(Region, int) onChangedRegion;
  final void Function(CityDistrict, int) onChangedCityOrDistrict;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((index + 1) != 1)
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr(
                    LocaleKeys.addressText,
                    namedArgs: {'text1': '(${index + 1})'},
                  ),
                  style: FontConstant.bodyMediumTextStyleFont(
                    color: TezColor.black,
                  ),
                ),

                const Spacer(),
                TezMotion(
                  onPressed: () {
                    onDelete(index);
                  },
                  child: Row(
                    children: [
                      Text(
                        tr(LocaleKeys.delete),
                        style: FontConstant.bodyMediumTextStyleFont(
                          color: TezColor.textError,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 8.h),

        DropdownCustomTez<Region>(
          isRequired: true,
          hintText: LocaleKeys.region,
          items: addressInput.regionsList,
          selectedItem: addressInput.region,
          onChanged: (value) {
            onChangedRegion(value, index);
          },
          itemT: LocaleKeys.region,
        ),

        SizedBox(height: 8.h),
        DropdownCustomTez<CityDistrict>(
          isRequired: true,
          hintText: LocaleKeys.cityOrDistrict,
          items: addressInput.citiesDistrictList,
          selectedItem: addressInput.cityOrDistrict,
          onChanged: (value) {
            onChangedCityOrDistrict(value, index);
          },
          itemT: LocaleKeys.cityOrDistrict,
        ),

        SizedBox(height: 8.h),
        if (addressInput.cityOrDistrict?.isRegion == true)
          DropdownCustomTez<CityVillage>(
            isRequired: true,
            hintText: LocaleKeys.cityOrDistrict,
            items: addressInput.citiesVillageList,
            selectedItem: addressInput.cityOrVillage,
            onChanged: (value) {
              onChangedCityOrVillage(value, index);
            },
            itemT: LocaleKeys.cityOrDistrict,
          ),
        if (addressInput.cityOrDistrict?.isRegion == true)
          SizedBox(height: 8.h),
        const RowTitle(text: LocaleKeys.market, isReq: true),
        SizedBox(height: 6.h),
        DropdownCustomTez<String>(
          hintText: LocaleKeys.nameOfMarket,
          items: shopType,
          selectedItem: addressInput.selectedShopType,
          onChanged: (value) {
            onChangedShopType(value, index);
          },
          itemT: LocaleKeys.nameOfMarket,
        ),

        SizedBox(height: 8.h),
        const RowTitle(text: LocaleKeys.street, isReq: true),
        SizedBox(height: 6.h),
        CustomInputField(
          textCapitalization: TextCapitalization.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 13.h,
          ),

          onChange: (p0) {
            onChanged();
          },
          maxLength: GeneralLimitConstant.baseLimit,
          fillColor: TezColor.backgroundPrimary,
          controller: addressInput.streetController,
          hintText: tr(LocaleKeys.street),
        ),
        SizedBox(height: 8.h),

        CustomInputField(
          textCapitalization: TextCapitalization.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 13.h,
          ),

          onChange: (p0) {
            onChanged();
          },
          maxLength: GeneralLimitConstant.baseLimit,
          fillColor: TezColor.backgroundPrimary,
          controller: addressInput.gisController,
          hintText: '${tr(LocaleKeys.link2gis)} *',
        ),
        SizedBox(height: 8.h),
        CustomInputField(
          textCapitalization: TextCapitalization.none,
          isFlag: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 13.h,
          ),

          onChange: (p0) {
            onChanged();
          },
          maxLength: GeneralLimitConstant.baseLimit,
          fillColor: TezColor.backgroundPrimary,
          controller: addressInput.phoneController,
          hintText: '+996 *',
        ),

        SizedBox(height: 8.h),
        CustomInputField(
          textCapitalization: TextCapitalization.none,
          isFlag: true,
          flagImage: ImageConstant.whatsapp,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 13.h,
          ),

          onChange: (p0) {
            onChanged();
          },
          maxLength: GeneralLimitConstant.baseLimit,
          fillColor: TezColor.backgroundPrimary,
          controller: addressInput.whatsappController,
          hintText: '+996 *',
        ),
      ],
    );
  }
}

class AddressInput {
  const AddressInput({
    required this.region,
    required this.cityOrDistrict,
    required this.cityOrVillage,
    required this.selectedShopType,
    required this.streetController,
    required this.regionsList,
    required this.citiesDistrictList,
    required this.citiesVillageList,
    required this.gisController,
    required this.phoneController,
    required this.whatsappController,
  });

  final Region? region;
  final CityDistrict? cityOrDistrict;
  final CityVillage? cityOrVillage;
  final String? selectedShopType;
  final List<Region> regionsList;
  final List<CityDistrict> citiesDistrictList;
  final List<CityVillage> citiesVillageList;
  final TextEditingController streetController;
  final TextEditingController gisController;
  final TextEditingController phoneController;
  final TextEditingController whatsappController;

  AddressInput copyWith({
    Region? region,
    Optional<CityDistrict?>? cityOrDistrict,
    Optional<CityVillage?>? cityOrVillage,
    String? selectedShopType,
    List<Region>? regionsList,
    List<CityDistrict>? citiesDistrictList,
    List<CityVillage>? citiesVillageList,
    TextEditingController? streetController,
    TextEditingController? gisController,
    TextEditingController? phoneController,
    TextEditingController? whatsappController,
  }) {
    return AddressInput(
      region: region ?? this.region,
      cityOrDistrict:
          cityOrDistrict?.hasValue == true
              ? cityOrDistrict!.value
              : this.cityOrDistrict,
      cityOrVillage:
          cityOrVillage?.hasValue == true
              ? cityOrVillage!.value
              : this.cityOrVillage,
      selectedShopType: selectedShopType ?? this.selectedShopType,
      regionsList: regionsList ?? this.regionsList,
      citiesDistrictList: citiesDistrictList ?? this.citiesDistrictList,
      citiesVillageList: citiesVillageList ?? this.citiesVillageList,
      streetController: streetController ?? this.streetController,
      gisController: gisController ?? this.gisController,
      phoneController: phoneController ?? this.phoneController,
      whatsappController: whatsappController ?? this.whatsappController,
    );
  }
}

class Optional<T> {
  final bool hasValue;
  final T? value;

  const Optional.absent() : hasValue = false, value = null;
  const Optional.present(this.value) : hasValue = true;

  static Optional<T> of<T>(T? value) => Optional.present(value);
}
