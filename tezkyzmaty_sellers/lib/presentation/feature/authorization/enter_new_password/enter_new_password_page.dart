import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tezkyzmaty_sellers/core/constants/general_limit_constant.dart';
import 'package:tezkyzmaty_sellers/core/router/router_path.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/core/utils/common_utils.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/injectable.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authorization/cubit/authorization_cubit.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_button.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_input_field.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';

class EnterNewPasswordArguments {
  EnterNewPasswordArguments({
    required this.token,
    this.isChangePassword = false,
  });
  final String token;
  final bool isChangePassword;
}

class EnterNewPasswordPage extends StatefulWidget {
  const EnterNewPasswordPage({super.key, required this.arguments});
  final EnterNewPasswordArguments arguments;

  @override
  State<EnterNewPasswordPage> createState() => _EnterNewPasswordPageState();
}

class _EnterNewPasswordPageState extends State<EnterNewPasswordPage> {
  final TextEditingController newPasswordCont = TextEditingController();
  final TextEditingController repeadPasswordCont = TextEditingController();

  bool isHide1Password = true;
  bool isHide2Password = true;
  bool get isMatchPassword => newPasswordCont.text == repeadPasswordCont.text;
  bool get isEnable =>
      newPasswordCont.text.trim().isNotEmpty &&
      repeadPasswordCont.text.isNotEmpty &&
      GeneralLimitConstant.isMinimumPasswordLength(newPasswordCont.text) &&
      GeneralLimitConstant.isMinimumPasswordLength(repeadPasswordCont.text);

  late AuthorizationCubit authorizationCubit;

  @override
  void initState() {
    authorizationCubit = getIt<AuthorizationCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authorizationCubit,
      child: BlocListener<AuthorizationCubit, AuthorizationState>(
        listener: (context, state) {
          if (state.authorizationStatus == AuthorizationStatus.loading) {
            context.loaderOverlay.show();
          }
          if (state.authorizationStatus == AuthorizationStatus.error) {
            context.loaderOverlay.hide();

            CommonUtil.showSnackBar(
              context,
              state.errorMessage.isNotEmpty ? state.errorMessage : 'Some error',
            );
          }
          if (state.authorizationStatus ==
              AuthorizationStatus.enterNewPasswordConfirmed) {
            context.loaderOverlay.hide();

            CommonUtil.showSnackBar(context, LocaleKeys.passwordChanged.tr());
            context.goNamed(RouterPath.login);
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child:
                        Text(
                          LocaleKeys.newPassword,
                          style: FontConstant.headingSmallTextStyleFont(
                            color: TezColor.black,
                          ),
                        ).tr(),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    LocaleKeys.newPassword,
                    style: FontConstant.bodyMediumTextStyleFont(
                      color: TezColor.black,
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
                    hintText: tr(LocaleKeys.enterPassword),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    LocaleKeys.repeatPassword,
                    style: FontConstant.bodyMediumTextStyleFont(
                      color: TezColor.black,
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
                    hintText: tr(LocaleKeys.enterPassword),
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
                        if (widget.arguments.isChangePassword) {
                          context.pushNamed(RouterPath.changePasswordSuccess);
                        } else {
                          context.go(RouterPath.home);
                        }
                        // authorizationCubit.enterNewPassword(
                        //   widget.arguments.token,
                        //   newPasswordCont.text,
                        // );
                      }
                    },
                  ),
                  const Spacer(),
                  if (!widget.arguments.isChangePassword)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.dontHaveAccount,
                          style: FontConstant.bodyMediumTextStyleFont(
                            color: TezColor.black.withValues(alpha: 0.5),
                          ),
                        ).tr(),
                        SizedBox(width: 5.w),
                        TezMotion(
                          onPressed: () {
                            context.go(RouterPath.signup);
                          },
                          child:
                              Text(
                                LocaleKeys.registration,
                                style:
                                    FontConstant.bodyMediumTextStyleFontUnderLine(
                                      color: TezColor.black,
                                    ),
                              ).tr(),
                        ),
                      ],
                    ),

                  SizedBox(height: 22.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
