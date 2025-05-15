// ignore_for_file: prefer_if_elements_to_conditional_expressions

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/constants/general_limit_constant.dart';
import 'package:tezkyzmaty_sellers/core/constants/property.dart';
import 'package:tezkyzmaty_sellers/core/router/router_path.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/utils/common_utils.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authorization/enter_new_password/enter_new_password_page.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/profile/cubit/profile_cubit.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/base_scaffold.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_button.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_input_field.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/input_variable.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController nameCont = TextEditingController();
  final TextEditingController emailCont = TextEditingController();
  final TextEditingController osooCont = TextEditingController();
  final TextEditingController innCont = TextEditingController();

  File? avatar;
  String avatarUrl = '';
  bool get isEnable =>
      nameCont.text.trim().isNotEmpty && (avatar != null || avatarUrl != '');
  bool isAnyChanged = false;

  @override
  void initState() {
    super.initState();
    nameCont.text = context.read<ProfileCubit>().state.profile?.name ?? '';
    emailCont.text = context.read<ProfileCubit>().state.profile?.email ?? '';
    osooCont.text = context.read<ProfileCubit>().state.profile?.osoo ?? '';
    innCont.text = context.read<ProfileCubit>().state.profile?.inn ?? '';
    avatarUrl = context.read<ProfileCubit>().state.profile?.image ?? '';
  }

  Future<void> pickImages(ImageSource imageSource) async {
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        setState(() {
          avatar = File(image.path);
        });
        if (mounted) {
          context.read<ProfileCubit>().updateAvatar(File(image.path));
        }
      }
    } on PlatformException {
      if (await Permission.camera.isPermanentlyDenied ||
          await Permission.photos.isPermanentlyDenied ||
          await Permission.camera.isDenied) {
        if (mounted) {
          CommonUtil.openSettingsImage(context);
        }
      }
    }
  }

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
          title: tr(LocaleKeys.profile),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: TezMotion(
                    onPressed: () {
                      showPickImagePopup();
                    },
                    child: SizedBox(
                      width: 56.r,
                      height: 56.r,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          avatarUrl.isNotEmpty && avatar == null
                              ? ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: avatarUrl,
                                  width: 56.r,
                                  height: 56.r,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder: (
                                    context,
                                    child,
                                    loadingProgress,
                                  ) {
                                    return Shimmer(
                                      color: TezColor.surfaceTertiary,
                                      child: Container(
                                        width: 56.r,
                                        height: 56.r,
                                        color: TezColor.surfaceTertiary,
                                      ),
                                    );
                                  },
                                  errorWidget: (context, error, stackTrace) {
                                    return Container(
                                      width: 56.r,
                                      height: 56.r,
                                      color: TezColor.surfaceTertiary,
                                    );
                                  },
                                ),
                              )
                              : avatar != null
                              ? ClipOval(
                                child: Image.file(
                                  avatar!,
                                  width: 56.r,
                                  height: 56.r,
                                  fit: BoxFit.cover,
                                ),
                              )
                              : Image.asset(
                                ImageConstant.avatar,
                                width: 56.r,
                                height: 56.r,
                                fit: BoxFit.cover,
                              ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: SvgPicture.asset(
                              SVGConstant.icCamera,
                              width: 20.r,
                              height: 16.r,
                              fit: BoxFit.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const RowTitle(text: LocaleKeys.nameSurname),

                SizedBox(height: 6.h),
                CustomInputField(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 18.h,
                  ),
                  onChange: (p0) {
                    setState(() {
                      isAnyChanged = true;
                    });
                  },
                  maxLength: GeneralLimitConstant.baseLimit,

                  fillColor: TezColor.backgroundPrimary,
                  controller: nameCont,
                  hintText: tr(LocaleKeys.enterFullName),
                ),
                SizedBox(height: 8.h),

                const RowTitle(text: LocaleKeys.email),
                SizedBox(height: 6.h),
                CustomInputField(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 18.h,
                  ),
                  onChange: (p0) {
                    setState(() {
                      isAnyChanged = true;
                    });
                  },
                  maxLength: GeneralLimitConstant.baseLimit,

                  fillColor: TezColor.backgroundPrimary,
                  controller: emailCont,
                  hintText: tr(LocaleKeys.enterEmail),
                ),
                SizedBox(height: 8.h),

                const RowTitle(text: LocaleKeys.osoo),
                SizedBox(height: 6.h),
                CustomInputField(
                  enabled: false,

                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 18.h,
                  ),
                  onChange: (p0) {
                    setState(() {
                      isAnyChanged = true;
                    });
                  },
                  maxLength: GeneralLimitConstant.baseLimit,

                  fillColor: TezColor.backgroundPrimary,
                  controller: osooCont,
                  hintText: tr(LocaleKeys.enterOsoo),
                ),
                SizedBox(height: 8.h),

                const RowTitle(text: LocaleKeys.inn),
                SizedBox(height: 6.h),
                CustomInputField(
                  enabled: false,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 18.h,
                  ),
                  onChange: (p0) {
                    setState(() {
                      isAnyChanged = true;
                    });
                  },
                  maxLength: GeneralLimitConstant.baseLimit,

                  fillColor: TezColor.backgroundPrimary,
                  controller: innCont,
                  hintText: tr(LocaleKeys.enterInn),
                ),
                SizedBox(height: 20.h),

                CustomButton(
                  width: double.infinity,
                  icon: SvgPicture.asset(
                    SVGConstant.icPassword,
                    width: 24.r,
                    height: 24.r,
                    fit: BoxFit.none,
                  ),
                  borderRadius: 16.r,
                  borderColor: TezColor.borderPrimary,
                  isGradient: false,
                  backgroundColor: TezColor.white,
                  textCenterAlign: false,
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 20.w,
                  ),
                  title: LocaleKeys.changePassword,
                  onPressed: () {
                    CommonUtil.showBaseDialog(
                      context,
                      title: tr(LocaleKeys.areYouSureChangePassword),
                      onPressed: () {
                        context.pushNamed(
                          RouterPath.enterNewPassword,
                          extra: EnterNewPasswordArguments(
                            token: '',
                            isChangePassword: true,
                          ),
                        );
                      },
                    );
                  },
                ),

                SizedBox(height: 16.h),

                CustomButton(
                  width: double.infinity,
                  isEnable: isEnable,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 24.w,
                  ),
                  fontSize: PropertyConstant.md2,
                  title: LocaleKeys.save,
                  onPressed: () {
                    if (isEnable) {
                      context.read<ProfileCubit>().updateName(
                        nameCont.text.trim(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
