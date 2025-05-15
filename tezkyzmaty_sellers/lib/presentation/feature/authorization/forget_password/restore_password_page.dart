import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
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
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_button.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_input_field.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';

class RestorePasswordPage extends StatefulWidget {
  const RestorePasswordPage({super.key});

  @override
  State<RestorePasswordPage> createState() => _RestorePasswordPageState();
}

class _RestorePasswordPageState extends State<RestorePasswordPage> {
  final TextEditingController numberCont = TextEditingController();
  bool get isEnable =>
      numberCont.text.trim().isNotEmpty &&
      validateInput(phoneInputFormatter.getUnmaskedText());

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
              AuthorizationStatus.forgotPasswordSendOTPConfirmed) {
            context.loaderOverlay.hide();

            CommonUtil.showSnackBar(context, LocaleKeys.otpSent.tr());
            context.pushNamed(
              RouterPath.otpConfirm,
              extra: OtpConfirmArguments(
                phone: state.phone,
                isRestorePassword: true,
                password: '',
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0.r),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      LocaleKeys.passwordRecovery.tr(),
                      style: FontConstant.headingSmallTextStyleFont(
                        color: TezColor.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  CustomInputField(
                    isFlag: true,
                    hintText: '+996',
                    inputFormatter: [phoneInputFormatter],
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.h,
                      vertical: 12.h,
                    ),
                    onChange: (p0) {
                      setState(() {});
                    },
                    fillColor: TezColor.backgroundPrimary,
                    controller: numberCont,
                  ),
                  SizedBox(height: 34.h),
                  CustomButton(
                    width: double.infinity,
                    isEnable: isEnable,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    title: LocaleKeys.getCode,
                    onPressed: () {
                      if (isEnable) {
                        // authorizationCubit.restorePassword(
                        //   numberCont.text.trim(),
                        // );
                        context.pushNamed(
                          RouterPath.otpConfirm,
                          extra: OtpConfirmArguments(
                            phone: numberCont.text.trim(),
                            isRestorePassword: true,
                            password: '',
                          ),
                        );
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
