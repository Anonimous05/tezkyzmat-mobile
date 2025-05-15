import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.confirmButtonText,
    required this.cancelButtonText,
    required this.onConfirm,
    required this.onCancel,
    this.isDelete = false,
    this.isHorizontal = false,
    this.content,
  });
  final String title;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final bool isDelete;
  final String? content;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      content: content != null
          ? Text(
              content!,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          : null,
      actions: [
        if (isHorizontal)
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: onCancel,
            child: Text(
              cancelButtonText,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        if (isHorizontal)
          CupertinoDialogAction(
            onPressed: onConfirm,
            isDestructiveAction: isDelete,
            child: Text(
              confirmButtonText,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        if (!isHorizontal)
          Column(
            children: [
              Divider(
                height: 1.h,
                color: CupertinoColors.separator,
              ),
              CupertinoDialogAction(
                onPressed: onConfirm,
                isDestructiveAction: isDelete,
                child: Text(
                  confirmButtonText,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Divider(
                height: 1.h,
                color: CupertinoColors.separator,
              ),
              CupertinoDialogAction(
                onPressed: onCancel,
                child: Text(
                  cancelButtonText,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }
}
