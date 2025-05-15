import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/core/utils/common_utils.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/profile/cubit/profile_cubit.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/app_unfocuser.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_button.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_input_field.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController newPasswordCont = TextEditingController();
  final TextEditingController repeadPasswordCont = TextEditingController();

  bool isHide1Password = true;
  bool isHide2Password = true;
  bool get isMatchPassword => newPasswordCont.text == repeadPasswordCont.text;
  bool get isEnable =>
      newPasswordCont.text.trim().isNotEmpty &&
      repeadPasswordCont.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return AppUnfocuser(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:
              Text(
                LocaleKeys.newPassword,
                style: FontConstant.labelMediumSemiTextStyleFont(
                  color: TezColor.black,
                ),
              ).tr(),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
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
            if (state.status == ProfileStatus.successUpdatePassword) {
              context.loaderOverlay.hide();

              CommonUtil.showSnackBar(context, tr(LocaleKeys.saved));
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      LocaleKeys.newPassword,
                      style: FontConstant.bodyMediumTextStyleFont(
                        color: TezColor.textHeading,
                      ),
                    ).tr(),
                    SizedBox(height: 8.h),
                    CustomInputField(
                      isPassword: isHide1Password,
                      suffixIcon: TezMotion(
                        onPressed: () {
                          setState(() {
                            isHide1Password = !isHide1Password;
                          });
                        },
                        child: SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: Icon(
                            isHide1Password
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                            size: 20.r,
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.h,
                        vertical: 12.h,
                      ),
                      onChange: (p0) {
                        setState(() {});
                      },
                      fillColor: TezColor.backgroundPrimary,
                      controller: newPasswordCont,
                      hintText: '',
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      LocaleKeys.repeatPassword,
                      style: FontConstant.bodyMediumTextStyleFont(
                        color: TezColor.textHeading,
                      ),
                    ).tr(),
                    SizedBox(height: 8.h),
                    CustomInputField(
                      isPassword: isHide2Password,
                      suffixIcon: TezMotion(
                        onPressed: () {
                          setState(() {
                            isHide2Password = !isHide2Password;
                          });
                        },
                        child: SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: Icon(
                            isHide2Password
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                            size: 20.r,
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.h,
                        vertical: 12.h,
                      ),
                      onChange: (p0) {
                        setState(() {});
                      },
                      fillColor: TezColor.backgroundPrimary,
                      controller: repeadPasswordCont,
                      hintText: '',
                    ),
                    SizedBox(height: 16.h),
                    if (isEnable && !isMatchPassword)
                      Center(
                        child:
                            Text(
                              LocaleKeys.passwordsNotMatching,
                              style: FontConstant.bodySmallTextStyleFont(
                                color: TezColor.textError,
                              ),
                            ).tr(),
                      ),
                    if (isEnable && !isMatchPassword) SizedBox(height: 16.h),
                    CustomButton(
                      width: double.infinity,
                      isEnable: isEnable && isMatchPassword,
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 24.w,
                      ),
                      title: LocaleKeys.save,
                      onPressed: () {
                        if (isEnable && isMatchPassword) {
                          context.read<ProfileCubit>().updatePassword(
                            newPasswordCont.text,
                            repeadPasswordCont.text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
