import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/data/models/classifiers.dart';

class DropdownCustomTez<T> extends StatelessWidget {
  const DropdownCustomTez({
    super.key,
    required this.hintText,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.itemT,
    this.isRequired = false,
  });
  final String hintText;
  final List<T> items;
  final T? selectedItem;
  final Function(T) onChanged;
  final String itemT;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    return DropdownFlutter<T>(
      hintText: tr(hintText),
      items: items,
      excludeSelected: false,
      decoration: CustomDropdownDecoration(
        closedBorder: Border.all(color: TezColor.borderPrimary),
        expandedBorder: Border.all(color: TezColor.borderPrimary),
        closedFillColor: Colors.white,
        expandedFillColor: Colors.white,
        closedSuffixIcon: Icon(
          CupertinoIcons.chevron_down,
          color: TezColor.black,
          size: 14.sp,
        ),
        expandedSuffixIcon: const Icon(
          CupertinoIcons.chevron_up,
          color: TezColor.black,
        ),
        expandedBorderRadius: BorderRadius.circular(8.r),
        closedBorderRadius: BorderRadius.circular(8.r),
      ),
      closedHeaderPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 13.w,
      ),
      hintBuilder:
          (context, hint, isSelected) => Text(
            isRequired ? '$hint *' : hint,
            style: FontConstant.bodyLargeTextStyleFont(color: TezColor.black50),
          ),

      listItemBuilder: (context, item, isSelected, onItemSelect) {
        if (item is CityDistrict) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getItemTitle(item),
                style: FontConstant.bodyLargeTextStyleFont(
                  color: TezColor.black,
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle, color: TezColor.black, size: 20.sp)
              else
                Icon(
                  Icons.circle_outlined,
                  color: TezColor.black50,
                  size: 20.sp,
                ),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getItemTitle(item),
                style: FontConstant.bodyLargeTextStyleFont(
                  color: TezColor.black,
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle, color: TezColor.black, size: 20.sp)
              else
                Icon(
                  Icons.circle_outlined,
                  color: TezColor.black50,
                  size: 20.sp,
                ),
            ],
          );
        }
      },
      headerBuilder:
          (context, selectedItem, enabled) => Text(
            getItemTitle(selectedItem),
            style: FontConstant.bodyLargeTextStyleFont(color: TezColor.black),
          ),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}

String getItemTitle(dynamic item) {
  if (item is Region) {
    return item.title;
  } else if (item is CityDistrict) {
    return item.title;
  } else if (item is CityVillage) {
    return item.title;
  }

  return item.toString();
}
