import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tezkyzmaty_sellers/core/constants/property.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/app_unfocuser.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    required this.title,
    required this.body,
    this.isBack = true,
  });
  final String title;
  final Widget body;
  final bool isBack;
  @override
  Widget build(BuildContext context) {
    return AppUnfocuser(
      child: Scaffold(
        backgroundColor: TezColor.black1c,
        appBar: AppBar(
          toolbarHeight: 70.h,
          forceMaterialTransparency: true,
          backgroundColor: TezColor.black1c,
          automaticallyImplyLeading: isBack,
          leading:
              context.canPop() && isBack
                  ? TezMotion(
                    onPressed: () {
                      context.pop();
                    },
                    child: Icon(
                      CupertinoIcons.chevron_left,
                      color: TezColor.white,
                      size: 24.r,
                    ),
                  )
                  : null,

          centerTitle: true,
          title: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: FontConstant.labelMediumTextStyleFont(
              fontWeight: FontWeight.w600,
              fontSize: PropertyConstant.md2,
              color: TezColor.white,
            ),
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
            decoration: BoxDecoration(
              color: TezColor.container,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
            ),
            child: body,
          ),
        ),
      ),
    );
  }
}
