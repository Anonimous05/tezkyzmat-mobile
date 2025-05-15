import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/custom_button.dart';

class CommonUtil {
  static bool isSnackBarScheduled = false;

  static void showBaseDialog(
    BuildContext context, {
    required String title,
    required Function onPressed,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: TezColor.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: FontConstant.labelMediumTextStyleFont(
                        color: TezColor.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          padding: EdgeInsets.symmetric(vertical: 13.h),
                          title: LocaleKeys.cancel,
                          backgroundColor: TezColor.disableButton,
                          isGradient: false,
                          borderRadius: 10.r,
                          onPressed: () {
                            context.pop();
                          },
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CustomButton(
                          borderRadius: 10.r,
                          padding: EdgeInsets.symmetric(vertical: 13.h),
                          title: LocaleKeys.yes,
                          onPressed: () {
                            context.pop();

                            onPressed();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  static Future<dynamic> openSettingsImage(BuildContext context) {
    return showCupertinoDialog(
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

  static void showSnackBar(
    BuildContext context,
    String message, {
    Color messageColor = Colors.black,
    bool isError = false,
  }) {
    Future.delayed(const Duration(milliseconds: 500), () {
      SmartDialog.showToast(
        '',
        // displayTime: const Duration(seconds: 2),
        builder:
            (context) => Padding(
              padding: EdgeInsets.only(top: 100.w, left: 20, right: 20),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color:
                        isError ? TezColor.borderError : TezColor.borderSuccess,
                  ),
                  color: isError ? TezColor.red50 : TezColor.green50,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      spreadRadius: 3,
                      color: Color.fromRGBO(26, 42, 97, 0.06),
                    ),
                  ],
                ),
                child: Text(
                  message,
                  style: TextStyle(color: messageColor, fontSize: 16),
                ),
              ),
            ),
        alignment: Alignment.topLeft,
        maskColor: Colors.transparent,
      ).then((value) => isSnackBarScheduled = false);
    });
  }

  static Future<void> showSnackBarWidget(
    BuildContext context, {
    required Widget widgetM,
    required Function funcThen,
  }) async {
    await SmartDialog.dismiss();
    await SmartDialog.show(
      displayTime: const Duration(seconds: 3),
      builder:
          (context) => Padding(
            padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
            child: Container(
              width: 281.w,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 10,
                    spreadRadius: 3,
                    color: Color.fromRGBO(26, 42, 97, 0.06),
                  ),
                ],
              ),
              child: widgetM,
            ),
          ),
      alignment: Alignment.center,
    );
    funcThen();
  }

  static void dismiss() {
    SmartDialog.dismiss();
  }
}
