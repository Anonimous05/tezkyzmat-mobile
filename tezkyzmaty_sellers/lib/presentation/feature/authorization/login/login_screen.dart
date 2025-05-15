import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tezkyzmaty_sellers/core/constants/general_limit_constant.dart';
import 'package:tezkyzmaty_sellers/core/router/router_path.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/core/utils/base_utils.dart';
import 'package:tezkyzmaty_sellers/core/utils/common_utils.dart';
import 'package:tezkyzmaty_sellers/core/utils/extension.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/injectable.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authorization/cubit/authorization_cubit.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/app_unfocuser.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_button.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_input_field.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController numberCont = TextEditingController();
  final TextEditingController passwordCont = TextEditingController();

  bool isHidePassword = true;

  late AuthorizationCubit authorizationCubit;

  @override
  void initState() {
    authorizationCubit = getIt<AuthorizationCubit>();
    super.initState();
  }

  bool get isEnableLogin =>
      passwordCont.text.trim().isNotEmpty &&
      numberCont.text.trim().isNotEmpty &&
      validateInput(phoneInputFormatter.getUnmaskedText()) &&
      GeneralLimitConstant.isMinimumPasswordLength(passwordCont.text.trim());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authorizationCubit,
      child: BlocConsumer<AuthorizationCubit, AuthorizationState>(
        listener: (context, state) {
          if (state.authorizationStatus == AuthorizationStatus.error) {
            CommonUtil.showSnackBar(
              context,
              state.errorMessage.isNotEmpty ? state.errorMessage : 'Some error',
            );
          }
          if (state.authorizationStatus == AuthorizationStatus.loginConfirmed) {
            CommonUtil.showSnackBar(context, tr(LocaleKeys.success));
            context.go(RouterPath.home);
          }
        },
        builder: (context, state) {
          return AppUnfocuser(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(24.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        child: Center(
                          child:
                              Text(
                                LocaleKeys.enter,
                                textAlign: TextAlign.center,
                                style: FontConstant.headingSmallTextStyleFont(
                                  color: TezColor.black,
                                ),
                              ).tr(),
                        ),
                      ),
                      SizedBox(height: 34.h),
                      Text(
                        LocaleKeys.number,
                        style: FontConstant.bodyMediumTextStyleFont(
                          color: TezColor.black,
                        ),
                      ).tr(),
                      SizedBox(height: 6.h),
                      CustomInputField(
                        isFlag: true,
                        inputFormatter: [phoneInputFormatter],

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.h,
                          vertical: 13.h,
                        ),

                        onChange: (p0) {
                          setState(() {});
                        },
                        maxLength: GeneralLimitConstant.getPhoneLimit(
                          numberCont.text,
                        ),
                        fillColor: TezColor.backgroundPrimary,
                        controller: numberCont,
                        hintText: '+996',
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            LocaleKeys.password,
                            style: FontConstant.bodyMediumTextStyleFont(
                              color: TezColor.textHeading,
                            ),
                          ).tr(),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      CustomInputField(
                        isPassword: isHidePassword,
                        suffixIcon: TezMotion(
                          onPressed: () {
                            setState(() {
                              isHidePassword = !isHidePassword;
                            });
                          },
                          child: SizedBox(
                            height: 20.h,
                            width: 20.h,
                            child: Icon(
                              isHidePassword
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
                        controller: passwordCont,
                        hintText: tr(LocaleKeys.enterPassword),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          const Spacer(),
                          TezMotion(
                            onPressed: () {
                              context.pushNamed(RouterPath.restorePassword);
                            },
                            child:
                                Text(
                                  LocaleKeys.forgotPassword,
                                  style: FontConstant.bodyMediumTextStyleFont(
                                    color: TezColor.black,
                                  ),
                                ).tr(),
                          ),
                        ],
                      ),
                      SizedBox(height: 34.h),
                      CustomButton(
                        width: double.infinity,
                        isEnable: isEnableLogin,
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 24.w,
                        ),
                        title: LocaleKeys.login,
                        onPressed: () {
                          if (isEnableLogin) {
                            context.go(RouterPath.home);
                            // authorizationCubit.login(
                            //   numberCont.text
                            //       .trim()
                            //       .replaceAll(' ', '')
                            //       .replaceAll('+', ''),
                            //   passwordCont.text.trim(),
                            // );
                          }
                        },
                      ),

                      const Spacer(),
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
                              context.pushNamed(RouterPath.signup);
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
          );
        },
      ),
    );
  }
}
