import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/constants/general_limit_constant.dart';
import 'package:tezkyzmaty_sellers/core/router/router_path.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/data/models/classifiers.dart';
import 'package:tezkyzmaty_sellers/data/models/temp_image_item.dart';
import 'package:tezkyzmaty_sellers/data/services/regions_service.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/address_widgets.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/app_unfocuser.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_button.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_input_field.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dropdown_custom.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/image_gallery_widget.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/input_variable.dart';

class RegistrationServicePage extends StatefulWidget {
  const RegistrationServicePage({super.key});

  @override
  State<RegistrationServicePage> createState() =>
      _RegistrationServicePageState();
}

class _RegistrationServicePageState extends State<RegistrationServicePage> {
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _tiktokController = TextEditingController();
  final TextEditingController _webSiteController = TextEditingController();

  final List<TempImageItem> _images = [];

  List<String> categoryType = [
    'Автозапчасти',
    'Автохимия',
    'Автоаксессуары',
    'Автошины',
  ];

  String? selectedCategoryType;

  List<String> shopType = ['Кудайберген', 'Дордой'];

  List<Region> _regionsList = [];

  final List<AddressInput> _addressInputs = [];

  bool get isEnableNext =>
      _images.isNotEmpty &&
      _shopNameController.text.trim().isNotEmpty &&
      _addressInputs.isNotEmpty &&
      _addressInputs.every(
        (address) =>
            address.region != null &&
            address.cityOrDistrict != null &&
            // ignore: avoid_bool_literals_in_conditional_expressions
            (address.cityOrDistrict?.isRegion == true
                ? address.cityOrVillage != null
                : true) &&
            address.selectedShopType != null &&
            address.streetController.text.trim().isNotEmpty &&
            address.gisController.text.trim().isNotEmpty &&
            address.whatsappController.text.trim().isNotEmpty &&
            address.phoneController.text.trim().isNotEmpty,
      );

  Future<void> showPickImagePopup() {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);

                await pickImages(ImageSource.gallery);
              },
              child: Text(
                tr(LocaleKeys.mediaLibrary),
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w400,
                  fontSize: 17.sp,
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);

                await pickImages(ImageSource.camera);
              },
              child: Text(
                tr(LocaleKeys.camera),
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w400,
                  fontSize: 17.sp,
                ),
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              tr(LocaleKeys.cancel),
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
                fontSize: 17.sp,
              ),
            ),
          ),
        );
      },
    );
  }

  void removeImage(int val) {
    setState(() {
      _images.removeAt(val);
    });
  }

  Future<void> pickImages(ImageSource imageSource) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _images.add(TempImageItem(id: -1, imageFile: File(image.path)));
        });
      }
    } on PlatformException {
      if (await Permission.camera.isPermanentlyDenied ||
          await Permission.photos.isPermanentlyDenied ||
          await Permission.camera.isDenied) {
        if (mounted) {
          showCupertinoDialog(
            context: context,
            builder:
                (BuildContext context) => CupertinoAlertDialog(
                  title:
                      Text(
                        LocaleKeys.accessDenied,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ).tr(),
                  content: Padding(
                    padding: EdgeInsets.only(top: 8.0.h),
                    child:
                        Text(
                          LocaleKeys.allowSettings,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ).tr(),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child:
                          Text(
                            LocaleKeys.cancel,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue,
                            ),
                          ).tr(),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoDialogAction(
                      child:
                          Text(
                            LocaleKeys.settings,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            ),
                          ).tr(),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        openAppSettings();
                      },
                    ),
                  ],
                ),
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _regionsList = RegionsService().getRegions();

    _addressInputs.add(
      AddressInput(
        regionsList: _regionsList,
        citiesDistrictList: [],
        citiesVillageList: [],
        region: null,
        cityOrDistrict: null,
        cityOrVillage: null,
        selectedShopType: null,

        streetController: TextEditingController(),
        gisController: TextEditingController(),
        phoneController: TextEditingController(),
        whatsappController: TextEditingController(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppUnfocuser(
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: TezMotion(
            onPressed: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              SVGConstant.icBack,
              height: 24.h,
              width: 24.w,
              fit: BoxFit.none,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  const RowTitle(text: LocaleKeys.nameOfCompany, isReq: true),
                  SizedBox(height: 6.h),
                  CustomInputField(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.h,
                      vertical: 13.h,
                    ),

                    onChange: (p0) {
                      setState(() {});
                    },
                    maxLength: GeneralLimitConstant.legalEntityMaxLimit,
                    fillColor: TezColor.backgroundPrimary,
                    controller: _shopNameController,
                    hintText: tr(LocaleKeys.shop),
                  ),
                  SizedBox(height: 22.h),

                  DropdownCustomTez<String>(
                    isRequired: true,
                    hintText: LocaleKeys.category,
                    items: categoryType,
                    selectedItem: selectedCategoryType,
                    onChanged: (value) {
                      setState(() {
                        selectedCategoryType = value;
                      });
                    },
                    itemT: LocaleKeys.category,
                  ),

                  SizedBox(height: 22.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RowTitle(text: LocaleKeys.filial, isReq: true),

                      const Spacer(),
                      TezMotion(
                        onPressed: () {
                          setState(() {
                            _addressInputs.add(
                              AddressInput(
                                regionsList: _regionsList,
                                citiesDistrictList: [],
                                citiesVillageList: [],
                                region: null,
                                cityOrDistrict: null,
                                cityOrVillage: null,
                                selectedShopType: null,
                                streetController: TextEditingController(),
                                gisController: TextEditingController(),
                                phoneController: TextEditingController(),
                                whatsappController: TextEditingController(),
                              ),
                            );
                          });
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

                        addressInput: _addressInputs[index],
                        onDelete: (value) {
                          setState(() {
                            _addressInputs.removeAt(value);
                          });
                        },
                        index: index,
                        onChanged: () {
                          setState(() {});
                        },
                        onChangedShopType: (value, index) {
                          setState(() {
                            _addressInputs[index] = _addressInputs[index]
                                .copyWith(selectedShopType: value);
                          });
                        },
                        onChangedCityOrDistrict: (value, index) {
                          setState(() {
                            _addressInputs[index] = _addressInputs[index]
                                .copyWith(cityOrDistrict: Optional.of(value));

                            _addressInputs[index] = _addressInputs[index]
                                .copyWith(
                                  citiesVillageList: RegionsService()
                                      .getCityVillageByDistrictId(value.id),
                                );
                          });
                        },
                        onChangedCityOrVillage: (value, index) {
                          setState(() {
                            _addressInputs[index] = _addressInputs[index]
                                .copyWith(cityOrVillage: Optional.of(value));

                            _addressInputs[index] = _addressInputs[index]
                                .copyWith(
                                  citiesVillageList: RegionsService()
                                      .getCityVillageByDistrictId(value.id),
                                );
                          });
                        },
                        onChangedRegion: (value, index) {
                          setState(() {
                            _addressInputs[index] = _addressInputs[index]
                                .copyWith(region: value);

                            _addressInputs[index] = _addressInputs[index]
                                .copyWith(
                                  citiesDistrictList: RegionsService()
                                      .getCityDistrictByRegionId(value.id),
                                );

                            _addressInputs[index] = _addressInputs[index]
                                .copyWith(
                                  cityOrVillage: Optional.of(null),
                                  cityOrDistrict: Optional.of(null),
                                );
                          });
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 12.h);
                    },
                    itemCount: _addressInputs.length,
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
                      setState(() {});
                    },
                    maxLines: null,
                    maxLength: GeneralLimitConstant.baseLimit,
                    fillColor: TezColor.backgroundPrimary,
                    controller: _instagramController,
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
                      setState(() {});
                    },
                    maxLength: GeneralLimitConstant.baseLimit,
                    fillColor: TezColor.backgroundPrimary,
                    controller: _tiktokController,
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
                      setState(() {});
                    },
                    maxLines: null,
                    maxLength: GeneralLimitConstant.baseLimit,
                    fillColor: TezColor.backgroundPrimary,
                    controller: _webSiteController,
                    hintText: tr(LocaleKeys.webSite),
                  ),
                  SizedBox(height: 22.h),

                  const RowTitle(text: LocaleKeys.photo, isReq: true),
                  SizedBox(height: 6.h),
                  if (_images.isEmpty)
                    TezMotion(
                      onPressed: () {
                        showPickImagePopup();
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
                  if (_images.isNotEmpty)
                    SizedBox(
                      height: 56.w,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ..._images.map(
                            (e) => TezMotion(
                              onPressed: () {
                                showDialog(
                                  barrierColor: Colors.black,
                                  context: context,
                                  builder:
                                      (context) => ImageGalleryWidget(
                                        images: _images,
                                        currentIndex: _images.indexOf(e),
                                        onDelete: (value) {
                                          removeImage(value.id);
                                        },
                                      ),
                                );
                              },
                              child: Container(
                                width: 56.w,
                                height: 56.w,
                                margin: EdgeInsets.only(right: 3.w),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: TezColor.borderPrimary,
                                  ),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6.r),
                                  child: Image.file(
                                    e.imageFile!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TezMotion(
                            onPressed: () {
                              showPickImagePopup();
                            },
                            child: Container(
                              width: 56.w,
                              height: 56.w,
                              margin: EdgeInsets.only(right: 3.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: TezColor.borderPrimary,
                                ),
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
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: CustomButton(
            width: double.infinity,
            isEnable: isEnableNext,
            padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w),
            title: LocaleKeys.next,
            onPressed: () {
              if (isEnableNext) {
                context.pushNamed(RouterPath.registrationWaitModerate);
              }
            },
          ),
        ),
      ),
    );
  }
}
