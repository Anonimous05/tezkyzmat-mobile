import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/base_scaffold.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle sectionTitle = FontConstant.bodyLargeTextStyleFont(
      fontWeight: FontWeight.w700,
      color: TezColor.black,
    );
    final TextStyle bulletStyle = FontConstant.bodyMediumTextStyleFont(
      color: TezColor.black,
    );
    final TextStyle bodyStyle = FontConstant.bodyMediumTextStyleFont(
      color: TezColor.black,
    );

    return BaseScaffold(
      title: tr(LocaleKeys.aboutApp),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Это приложение создано для удобного поиска и подбора автозапчастей.\n'
              ' Покупатели оставляют заявки с нужными деталями, а продавцы получают эти заявки и быстро отвечают — есть ли нужная запчасть в наличии или нет.',
              style: bodyStyle,
            ),
            SizedBox(height: 20.h),

            // Покупатели
            Row(
              children: [
                Text('📦', style: TextStyle(fontSize: 22.sp)),
                SizedBox(width: 8.w),
                Text('Для покупателей:', style: sectionTitle),
              ],
            ),
            SizedBox(height: 8.h),
            _dash('Быстрое создание заявки', bulletStyle),
            _dash('Ответы от нескольких продавцов', bulletStyle),
            _dash('Удобный выбор подходящего варианта', bulletStyle),

            SizedBox(height: 20.h),

            // Продавцы
            Row(
              children: [
                Text('🛠️', style: TextStyle(fontSize: 22.sp)),
                SizedBox(width: 8.w),
                Text('Для продавцов:', style: sectionTitle),
              ],
            ),
            SizedBox(height: 8.h),
            _dash('Получение заявок в реальном времени', bulletStyle),
            _dash('Удобная система отметок \"Есть / Нет\"', bulletStyle),
            _dash('Больше клиентов без лишних звонков', bulletStyle),

            SizedBox(height: 20.h),
            Text(
              'Приложение экономит время и упрощает общение между покупателями и продавцами запчастей.',
              style: bodyStyle,
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _dash(String text, TextStyle style) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('— ', style: style),
          Expanded(child: Text(text, style: style)),
        ],
      ),
    );
  }
}
