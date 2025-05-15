import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/constants/general_limit_constant.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/data/models/classifiers.dart';
import 'package:tezkyzmaty_sellers/data/models/temp_image_item.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/address_widgets.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_input_field.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dropdown_custom.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/image_gallery_widget.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/input_variable.dart';

class RegistrationSellPartsPageTwo extends StatelessWidget {
  const RegistrationSellPartsPageTwo({
    super.key,
    required this.shopNameController,
    required this.descriptionController,
    required this.instagramController,
    required this.tiktokController,
    required this.webSiteController,
    required this.shopType,
    required this.images,
    required this.onChangedShopType,
    required this.onChanged,
    required this.onImageAdd,
    required this.onImageDelete,
    required this.addressInputs,
    required this.onAddressDelete,
    required this.onAddressAdd,

    required this.onChangedCityOrDistrict,
    required this.onChangedCityOrVillage,
    required this.onChangedRegion,
    required this.selectedCategory,
    required this.onChangedCategory,
    required this.categories,
  });

  final TextEditingController shopNameController;
  final TextEditingController descriptionController;
  final TextEditingController instagramController;
  final TextEditingController tiktokController;
  final TextEditingController webSiteController;

  final List<String> shopType;
  final List<TempImageItem> images;
  final List<String> categories;
  final List<AddressInput> addressInputs;
  final String? selectedCategory;

  final Function() onChanged;
  final Function() onImageAdd;
  final Function(TempImageItem) onImageDelete;
  final Function(int) onAddressDelete;
  final Function() onAddressAdd;
  final Function(String) onChangedCategory;

  final Function(CityDistrict, int) onChangedCityOrDistrict;
  final Function(CityVillage, int) onChangedCityOrVillage;
  final Function(Region, int) onChangedRegion;
  final Function(String, int) onChangedShopType;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const RowTitle(text: LocaleKeys.nameOfShop, isReq: true),
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
              controller: shopNameController,
              hintText: tr(LocaleKeys.shop),
            ),
            SizedBox(height: 22.h),

            DropdownCustomTez<String>(
              isRequired: true,
              hintText: LocaleKeys.category,
              items: categories,
              selectedItem: selectedCategory,
              onChanged: (value) {
                onChangedCategory(value);
              },
              itemT: LocaleKeys.category,
            ),

            SizedBox(height: 22.h),

            const RowTitle(text: LocaleKeys.description, isReq: true),
            SizedBox(height: 6.h),
            CustomInputField(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 13.h,
              ),

              onChange: (p0) {
                onChanged();
              },
              maxLines: null,
              maxLength: GeneralLimitConstant.legalEntityMaxLimit,
              fillColor: TezColor.backgroundPrimary,
              controller: descriptionController,
              hintText: tr(LocaleKeys.enterText),
            ),
            SizedBox(height: 22.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RowTitle(text: LocaleKeys.filial, isReq: true),

                const Spacer(),
                TezMotion(
                  onPressed: () {
                    onAddressAdd();
                  },
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.plus,
                        size: 16.r,
                        color: TezColor.textAction,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        tr(LocaleKeys.add),
                        style: FontConstant.bodyMediumTextStyleFont(
                          color: TezColor.textAction,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return AddressWidgets(
                  shopType: shopType,
                  onChangedShopType: onChangedShopType,

                  addressInput: addressInputs[index],
                  onDelete: (value) {
                    onAddressDelete(value);
                  },
                  index: index,
                  onChanged: () {
                    onChanged();
                  },
                  onChangedCityOrDistrict: (value, index) {
                    onChangedCityOrDistrict(value, index);
                  },
                  onChangedCityOrVillage: (value, index) {
                    onChangedCityOrVillage(value, index);
                  },
                  onChangedRegion: (value, index) {
                    onChangedRegion(value, index);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 12.h);
              },
              itemCount: addressInputs.length,
            ),

            SizedBox(height: 22.h),

            const RowTitle(text: LocaleKeys.socialMedia),
            SizedBox(height: 6.h),
            CustomInputField(
              textCapitalization: TextCapitalization.none,

              flagImage: ImageConstant.instagram,
              isFlag: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 13.h,
              ),

              onChange: (p0) {
                onChanged();
              },
              maxLines: null,
              maxLength: GeneralLimitConstant.baseLimit,
              fillColor: TezColor.backgroundPrimary,
              controller: instagramController,
              hintText: tr(LocaleKeys.instagram),
            ),
            SizedBox(height: 6.h),
            CustomInputField(
              textCapitalization: TextCapitalization.none,

              flagImage: ImageConstant.tiktok,
              isFlag: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 13.h,
              ),

              onChange: (p0) {
                onChanged();
              },
              maxLines: null,
              maxLength: GeneralLimitConstant.baseLimit,
              fillColor: TezColor.backgroundPrimary,
              controller: tiktokController,
              hintText: tr(LocaleKeys.tiktok),
            ),
            SizedBox(height: 6.h),
            CustomInputField(
              textCapitalization: TextCapitalization.none,
              flagImage: ImageConstant.webSite,
              isFlag: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 13.h,
              ),

              onChange: (p0) {
                onChanged();
              },
              maxLines: null,
              maxLength: GeneralLimitConstant.baseLimit,
              fillColor: TezColor.backgroundPrimary,
              controller: webSiteController,
              hintText: tr(LocaleKeys.webSite),
            ),
            SizedBox(height: 22.h),

            const RowTitle(text: LocaleKeys.photo, isReq: true),
            SizedBox(height: 6.h),
            if (images.isEmpty)
              TezMotion(
                onPressed: () {
                  onImageAdd();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    border: Border.all(color: TezColor.borderPrimary),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.camera_fill,
                        size: 24.r,
                        color: TezColor.black1c,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        LocaleKeys.addPhoto,
                        style: FontConstant.bodyLargeTextStyleFont(
                          color: TezColor.black1c,
                        ),
                      ).tr(),
                    ],
                  ),
                ),
              ),
            if (images.isNotEmpty)
              SizedBox(
                height: 56.w,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...images.map(
                      (e) => TezMotion(
                        onPressed: () {
                          showDialog(
                            barrierColor: Colors.black,
                            context: context,
                            builder:
                                (context) => ImageGalleryWidget(
                                  images: images,
                                  currentIndex: images.indexOf(e),
                                  onDelete: (value) {
                                    onImageDelete(value);
                                  },
                                ),
                          );
                        },
                        child: Container(
                          width: 56.w,
                          height: 56.w,
                          margin: EdgeInsets.only(right: 3.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: TezColor.borderPrimary),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.r),
                            child: Image.file(e.imageFile!, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                    TezMotion(
                      onPressed: () {
                        onImageAdd();
                      },
                      child: Container(
                        width: 56.w,
                        height: 56.w,
                        margin: EdgeInsets.only(right: 3.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: TezColor.borderPrimary),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.plus,
                            size: 24.r,
                            color: TezColor.black1c,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
