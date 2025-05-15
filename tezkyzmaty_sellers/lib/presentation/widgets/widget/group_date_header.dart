import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';

class GroupHeaderDate extends StatelessWidget {
  const GroupHeaderDate({this.date, super.key});
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return date == null
        ? const SizedBox()
        : Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8.0,
                ),
                child: Text(
                  DateFormat('EEEE, d MMM').format(date!),
                  textAlign: TextAlign.center,
                  style: FontConstant.labelMediumSemiTextStyleFont(
                    color: TezColor.textBody,
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
