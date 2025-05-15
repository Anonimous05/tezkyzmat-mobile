import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pinput/pinput.dart';
import 'package:tezkyzmaty_sellers/core/router/router_path.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/core/utils/common_utils.dart';
import 'package:tezkyzmaty_sellers/core/utils/extension.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/injectable.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authorization/cubit/authorization_cubit.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authorization/enter_new_password/enter_new_password_page.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/app_unfocuser.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_button.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';

class OtpConfirmArguments {
  OtpConfirmArguments({
    required this.phone,
    this.isRestorePassword = false,
    required this.password,
  });
  final String phone;
  final bool isRestorePassword;
  final String password;
}

class OtpConfirmScreen extends StatefulWidget {
  const OtpConfirmScreen({super.key, required this.arguments});
  final OtpConfirmArguments arguments;

  @override
  State<OtpConfirmScreen> createState() => _OtpConfirmScreenState();
}

class _OtpConfirmScreenState extends State<OtpConfirmScreen> {
  bool isEnableSubmit = false;
  bool isOTPWrong = false;
  late AuthorizationCubit authorizationCubit;
  String otpVal = '';
  int _countdown = 60;
  bool _canResend = false;
  Timer? _timer;

  @override
  void initState() {
    authorizationCubit = getIt<AuthorizationCubit>();
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _canResend = true;
          _timer?.cancel();
        }
      });
    });
  }

  void _resendCode() {
    setState(() {
      _countdown = 60;
      _canResend = false;
    });
    _startTimer();
    if (widget.arguments.isRestorePassword) {
      authorizationCubit.restorePassword(widget.arguments.phone);
    } else {
      authorizationCubit.registerLogin(
        widget.arguments.phone,
        widget.arguments.password,
      );
    }
  }

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
          }
          if (state.authorizationStatus ==
              AuthorizationStatus.registrationOTPConfirmed) {
            context.loaderOverlay.hide();

            CommonUtil.showSnackBar(context, tr(LocaleKeys.success));
            if (state.isNewUser) {
              context.pushNamed(RouterPath.registrationSuccess);
            } else {
              context.go(RouterPath.home);
            }
          }
          if (state.authorizationStatus ==
              AuthorizationStatus.forgotPasswordOTPConfirmed) {
            context.loaderOverlay.hide();

            context.pushNamed(
              RouterPath.enterNewPassword,
              extra: EnterNewPasswordArguments(token: state.token),
            );
          }
        },
        builder: (context, state) {
          return AppUnfocuser(
            child: Scaffold(
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
                                LocaleKeys.enterCode,
                                textAlign: TextAlign.center,
                                style: FontConstant.headingSmallTextStyleFont(
                                  color: TezColor.textHeading,
                                ),
                              ).tr(),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              LocaleKeys.weSendCode,
                              textAlign: TextAlign.center,
                              style: FontConstant.bodyMediumTextStyleFont(
                                color: TezColor.black,
                              ),
                            ).tr(),
                            Text(
                              phoneInputFormatter.getMaskedText(),
                              textAlign: TextAlign.center,
                              style: FontConstant.bodyMediumTextStyleFont(
                                color: TezColor.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Center(
                        child: Pinput(
                          autofocus: true,
                          defaultPinTheme: PinTheme(
                            height: 50.h,
                            width: 50.w,

                            textStyle: FontConstant.headingSmallTextStyleFont(
                              color: isOTPWrong ? TezColor.red : TezColor.black,
                            ),
                          ),

                          onChanged: (pin) {
                            if (pin.length == 4) {
                              setState(() {
                                isEnableSubmit = true;
                                otpVal = pin;
                              });
                            } else {
                              setState(() {
                                isEnableSubmit = false;
                                otpVal = pin;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 10.h),

                      if (isEnableSubmit)
                        CustomButton(
                          width: double.infinity,
                          isEnable: isEnableSubmit,
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 24.w,
                          ),
                          title: LocaleKeys.confirm,
                          onPressed: () {
                            if (isEnableSubmit) {
                              if (widget.arguments.isRestorePassword) {
                                // authorizationCubit.otpVerifyRestorePassword(
                                //   widget.arguments.phone,
                                //   otpVal,
                                // );
                                context.pushNamed(
                                  RouterPath.enterNewPassword,
                                  extra: EnterNewPasswordArguments(
                                    token: state.token,
                                  ),
                                );
                              } else {
                                // authorizationCubit.otpVerify(
                                //   widget.arguments.phone
                                //       .trim()
                                //       .replaceAll(' ', '')
                                //       .replaceAll('+', ''),
                                //   widget.arguments.password,
                                //   otpVal,
                                // );
                                context.pushNamed(
                                  RouterPath.registrationSuccess,
                                );
                              }
                            }
                          },
                        ),
                      const Spacer(),
                      Center(
                        child:
                            _canResend
                                ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      LocaleKeys.dontHaveCode.tr(),
                                      style:
                                          FontConstant.bodyLargeTextStyleFont(
                                            color: TezColor.black.withAlpha(
                                              200,
                                            ),
                                          ),
                                    ),
                                    SizedBox(width: 10.w),
                                    TezMotion(
                                      onPressed: _resendCode,
                                      child: Text(
                                        LocaleKeys.requestCode.tr(),
                                        style:
                                            FontConstant.bodyLargeTextStyleFont(
                                              color: TezColor.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ],
                                )
                                : RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: LocaleKeys.sendAgain.tr(),
                                        style:
                                            FontConstant.bodyLargeTextStyleFont(
                                              color: TezColor.black,
                                            ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' ${_countdown ~/ 60}:${(_countdown % 60).toString().padLeft(2, '0')}',
                                        style:
                                            FontConstant.bodyLargeTextStyleFont(
                                              color: TezColor.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                      ),
                      SizedBox(height: 24.h),
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
