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
import 'package:tezkyzmaty_sellers/core/router/router_path.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/data/models/classifiers.dart';
import 'package:tezkyzmaty_sellers/data/models/temp_image_item.dart';
import 'package:tezkyzmaty_sellers/data/services/regions_service.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/registration/view/widgets/registration_sell_parts_page_one.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/registration/view/widgets/registration_sell_parts_page_two.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/address_widgets.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/app_unfocuser.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_button.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/step_widget.dart';

class RegistrationSellPartsPage extends StatefulWidget {
  const RegistrationSellPartsPage({super.key});

  @override
  State<RegistrationSellPartsPage> createState() =>
      _RegistrationSellPartsPageState();
}

class _RegistrationSellPartsPageState extends State<RegistrationSellPartsPage> {
  int currentStep = 1;

  final PageController _pageController = PageController();

  //First Page
  List<String> registrationType = ['ИП', 'ОсОО'];
  String? selectedRegistrationType;

  List<String> ndsType = [
    'ИП без НДС',
    'ОсОО без НДС',
    'ИП с НДС',
    'ОсОО с НДС',
  ];

  String? selectedNdsType;

  final TextEditingController _nameOfLegalEntityController =
      TextEditingController();
  final TextEditingController _innController = TextEditingController();
  //First Page

  //Second Page
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _tiktokController = TextEditingController();
  final TextEditingController _webSiteController = TextEditingController();
  List<Region> _regionsList = [];

  final List<AddressInput> _addressInputs = [];

  List<String> categoryType = [
    'Автозапчасти',
    'Автохимия',
    'Автоаксессуары',
    'Автошины',
  ];

  String? selectedCategoryType;

  List<String> shopType = ['Кудайберген', 'Дордой'];
  final List<TempImageItem> _images = [];
  //Second Page

  bool get isEnableFirstButton => selectedRegistrationType != null;
  bool get isEnableSecondButton =>
      _images.isNotEmpty &&
      _descriptionController.text.trim().isNotEmpty &&
      _shopNameController.text.trim().isNotEmpty;

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
          leading: TezMotion(
            onPressed: () {
              if (currentStep == 1) {
                Navigator.pop(context);
              } else {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  tr(
                    LocaleKeys.completeSteps,

                    namedArgs: {'text1': currentStep.toString(), 'text2': '2'},
                  ),
                  style: FontConstant.titleSmallTextStyleFont(
                    color: TezColor.black50,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              StepWidget(currentStep: currentStep, totalSteps: 2),
              SizedBox(height: 20.h),

              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentStep = value + 1;
                    });
                  },
                  children: [
                    RegistrationSellPartsPageOne(
                      nameOfLegalEntityController: _nameOfLegalEntityController,
                      innController: _innController,
                      selectedRegistrationType: selectedRegistrationType,
                      selectedNdsType: selectedNdsType,
                      registrationType: registrationType,
                      ndsType: ndsType,
                      onChangedRegistrationType: (value) {
                        setState(() {
                          selectedRegistrationType = value;
                        });
                      },
                      onChangedNdsType: (value) {
                        setState(() {
                          selectedNdsType = value;
                        });
                      },
                      onChanged: () {
                        setState(() {});
                      },
                    ),
                    RegistrationSellPartsPageTwo(
                      shopNameController: _shopNameController,
                      descriptionController: _descriptionController,
                      instagramController: _instagramController,
                      tiktokController: _tiktokController,
                      webSiteController: _webSiteController,
                      shopType: shopType,
                      images: _images,
                      selectedCategory: selectedCategoryType,
                      categories: categoryType,

                      onChangedCategory: (value) {
                        setState(() {
                          selectedCategoryType = value;
                        });
                      },
                      onChanged: () {
                        setState(() {});
                      },
                      onImageAdd: () {
                        showPickImagePopup();
                      },
                      onImageDelete: (value) {
                        removeImage(value.id);
                      },
                      addressInputs: _addressInputs,
                      onAddressDelete: (value) {
                        setState(() {
                          _addressInputs.removeAt(value);
                        });
                      },
                      onAddressAdd: () {
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: CustomButton(
            width: double.infinity,
            isEnable:
                currentStep == 1 ? isEnableFirstButton : isEnableSecondButton,
            padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w),
            title: LocaleKeys.next,
            onPressed: () {
              if (currentStep == 1) {
                if (isEnableFirstButton) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              }
              if (currentStep == 2) {
                if (isEnableSecondButton) {
                  context.pushNamed(RouterPath.registrationWaitModerate);
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
