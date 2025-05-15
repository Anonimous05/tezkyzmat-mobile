import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
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
import 'package:tezkyzmaty_sellers/presentation/feature/authorization/signup/otp_confirm_screen.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/accept_policy_widget.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/app_unfocuser.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_button.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_input_field.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController numberCont = TextEditingController();
  final TextEditingController passwordCont = TextEditingController();

  bool isHidePassword = true;
  bool isAcceptPolicy = false;

  late AuthorizationCubit authorizationCubit;

  @override
  void initState() {
    authorizationCubit = getIt<AuthorizationCubit>();
    super.initState();
  }

  bool get isEnableLogin =>
      numberCont.text.trim().isNotEmpty &&
      passwordCont.text.trim().isNotEmpty &&
      validateInput(phoneInputFormatter.getUnmaskedText()) &&
      GeneralLimitConstant.isMinimumPasswordLength(passwordCont.text.trim()) &&
      isAcceptPolicy;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authorizationCubit,
      child: BlocConsumer<AuthorizationCubit, AuthorizationState>(
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
              AuthorizationStatus.registrationSendOTPConfirmed) {
            context.loaderOverlay.hide();

            CommonUtil.showSnackBar(context, LocaleKeys.otpSent.tr());
            context.pushNamed(
              RouterPath.otpConfirm,
              extra: OtpConfirmArguments(
                phone: state.phone,
                password: passwordCont.text.trim(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstant.registrationBackground),
                fit: BoxFit.fill,
              ),
            ),
            child: AppUnfocuser(
              child: Scaffold(
                backgroundColor: Colors.transparent,

                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(20.r),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              ImageConstant.logo,
                              height: 137.h,
                              width: 137.h,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(height: 50.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                            child: Center(
                              child:
                                  Text(
                                    LocaleKeys.registration,
                                    textAlign: TextAlign.center,
                                    style:
                                        FontConstant.headingSmallTextStyleFont(
                                          color: TezColor.black,
                                        ),
                                  ).tr(),
                            ),
                          ),
                          SizedBox(height: 60.h),

                          Text(
                            LocaleKeys.number,
                            style: FontConstant.bodyMediumTextStyleFont(
                              color: TezColor.black,
                            ),
                          ).tr(),
                          SizedBox(height: 6.h),
                          CustomInputField(
                            isFlag: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.h,
                              vertical: 13.h,
                            ),
                            onChange: (p0) {
                              setState(() {});
                            },
                            maxLength: 30,
                            fillColor: TezColor.backgroundPrimary,
                            controller: numberCont,
                            hintText: '+996',
                            inputFormatter: [phoneInputFormatter],
                          ),
                          SizedBox(height: 22.h),
                          Text(
                            LocaleKeys.password,
                            style: FontConstant.bodyMediumTextStyleFont(
                              color: TezColor.black,
                            ),
                          ).tr(),
                          SizedBox(height: 6.h),
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
                            maxLength: GeneralLimitConstant.getPhoneLimit(
                              passwordCont.text,
                            ),
                            fillColor: TezColor.backgroundPrimary,
                            controller: passwordCont,
                            hintText: tr(LocaleKeys.enterPassword),
                          ),
                          SizedBox(height: 15.h),
                          AcceptPolicyWidget(
                            isAccept: isAcceptPolicy,
                            onChanged: (p0) {
                              setState(() {
                                isAcceptPolicy = p0;
                              });
                            },
                          ),
                          SizedBox(height: 22.h),

                          CustomButton(
                            width: double.infinity,
                            isEnable: isEnableLogin,
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 24.w,
                            ),
                            title: LocaleKeys.register,
                            onPressed: () {
                              if (isEnableLogin) {
                                // authorizationCubit.registerLogin(
                                //   numberCont.text
                                //       .trim()
                                //       .replaceAll(' ', '')
                                //       .replaceAll('+', ''),
                                //   passwordCont.text.trim(),
                                // );
                                context.pushNamed(
                                  RouterPath.otpConfirm,
                                  extra: OtpConfirmArguments(
                                    phone: state.phone,
                                    password: passwordCont.text.trim(),
                                  ),
                                );
                              }
                            },
                          ),

                          SizedBox(height: 22.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                LocaleKeys.alreadyHaveAccount,
                                style: FontConstant.bodyMediumTextStyleFont(
                                  color: TezColor.black,
                                ),
                              ).tr(),
                              SizedBox(width: 5.w),
                              TezMotion(
                                onPressed: () {
                                  context.pushNamed(RouterPath.login);
                                },
                                child:
                                    Text(
                                      LocaleKeys.login,
                                      style:
                                          FontConstant.bodyMediumTextStyleFontUnderLine(
                                            color: TezColor.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ).tr(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
