import 'package:flutter/material.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: Center(
            child: CircularProgressIndicator(color: TezColor.primary),
          ),
        ),
      ],
    );
  }
}
