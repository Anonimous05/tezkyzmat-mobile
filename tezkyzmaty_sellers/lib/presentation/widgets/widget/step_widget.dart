import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';

class StepWidget extends StatelessWidget {
  const StepWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });
  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps * 2 - 1, (index) {
        if (index.isEven) {
          final int step = index ~/ 2 + 1;
          final bool isCompleted = step < currentStep;
          final bool isCurrent = step == currentStep;
          return Container(
            width: 23.r,
            height: 23.r,
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    isCompleted || isCurrent
                        ? TezColor.green1000
                        : TezColor.borderPrimary,
                width: isCompleted || isCurrent ? 2.r : 1.r,
              ),
              color: isCompleted ? TezColor.green1000 : Colors.white,
            ),
            child: Center(
              child:
                  isCompleted
                      ? Icon(Icons.check, color: Colors.white, size: 20.r)
                      : Text(
                        '$step',
                        style: FontConstant.bodySmallTextStyleFont(
                          color: TezColor.black,
                        ),
                      ),
            ),
          );
        } else {
          return Row(
            children: List.generate(
              5,
              (dotIdx) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
