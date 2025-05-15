import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';

class CustomBottomNavBarItem {
  BottomNavigationBarItem getItem({
    required final int selectedIndex,
    required final String activeImageName,
    required final int itemIndex,
    required final String label,
    final bool isColored = true,
    final bool isEmpty = false,
    final bool isNewChatMessage = false,
  }) {
    return BottomNavigationBarItem(
      label: label.tr(),
      icon:
          isEmpty
              ? const SizedBox()
              : Container(
                decoration: BoxDecoration(
                  color:
                      selectedIndex == itemIndex
                          ? TezColor.FEF4D9
                          : TezColor.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
                margin: EdgeInsets.only(bottom: 4.h),
                child: SvgPicture.asset(
                  activeImageName,
                  height: 32.r,
                  width: 64.r,

                  colorFilter:
                      isColored
                          ? ColorFilter.mode(
                            selectedIndex == itemIndex
                                ? TezColor.activeTab
                                : TezColor.inActiveTab,
                            BlendMode.srcIn,
                          )
                          : null,
                ),
              ),
    );
  }
}
