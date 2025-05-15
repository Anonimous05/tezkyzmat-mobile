import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/base_scaffold.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = FontConstant.labelMediumTextStyleFont(
      fontWeight: FontWeight.w600,
      color: TezColor.black,
    );
    final TextStyle bulletStyle = FontConstant.bodyMediumTextStyleFont(
      color: TezColor.black,
    );
    final TextStyle bodyStyle = FontConstant.bodyMediumTextStyleFont(
      color: TezColor.black,
    );

    return BaseScaffold(
      title: tr(LocaleKeys.privacyPolicy),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Настоящая Политика конфиденциальности определяет порядок сбора, хранения и использования персональных данных пользователей в приложении по поиску и продаже автозапчастей.',
              style: bodyStyle,
            ),
            SizedBox(height: 16.h),
            Text('1. Какие данные мы собираем:', style: titleStyle),
            SizedBox(height: 4.h),
            _bullet('Номер телефона', bulletStyle),
            _bullet('Имя (если указано)', bulletStyle),
            _bullet(
              'Информация о заявках (наименование запчастей, описание, фото)',
              bulletStyle,
            ),
            _bullet(
              'Данные о взаимодействии с приложением (дата, время, отклики и т.д.)',
              bulletStyle,
            ),
            SizedBox(height: 12.h),
            Text('2. Как мы используем данные:', style: titleStyle),
            SizedBox(height: 4.h),
            _bullet('Для обработки и отправки заявок продавцам', bulletStyle),
            _bullet('Для связи между покупателями и продавцами', bulletStyle),
            _bullet(
              'Для улучшения работы приложения и поддержки пользователей',
              bulletStyle,
            ),
            _bullet('Для защиты от мошенничества и спама', bulletStyle),
            SizedBox(height: 12.h),
            Text('3. Кто имеет доступ:', style: titleStyle),
            SizedBox(height: 4.h),
            _bullet(
              'Только вы и продавцы, получившие вашу заявку',
              bulletStyle,
            ),
            _bullet(
              'Администрация сервиса (техническая поддержка)',
              bulletStyle,
            ),
            _bullet(
              'Мы не передаём данные третьим лицам без вашего согласия',
              bulletStyle,
            ),
            SizedBox(height: 12.h),
            Text('4. Безопасность:', style: titleStyle),
            SizedBox(height: 4.h),
            _bullet(
              'Мы используем современные технические средства защиты данных и обеспечиваем конфиденциальность передаваемой информации.',
              bulletStyle,
            ),
            SizedBox(height: 12.h),
            Text('5. Ваши права:', style: titleStyle),
            SizedBox(height: 4.h),
            _bullet(
              'Вы можете в любое время изменить или удалить свою информацию',
              bulletStyle,
            ),
            _bullet(
              'Вы можете запросить удаление аккаунта и всех связанных данных',
              bulletStyle,
            ),
            SizedBox(height: 12.h),
            Text('6. Контакты:', style: titleStyle),
            SizedBox(height: 4.h),
            Text(
              'Если у вас возникли вопросы по поводу конфиденциальности, свяжитесь с нами:',
              style: bodyStyle,
            ),
            SizedBox(height: 8.h),
            TezMotion(
              onPressed: () {},
              child: Text(
                'email@example.com',
                style: FontConstant.bodyMediumTextStyleFont(
                  color: TezColor.blue,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            TezMotion(
              onPressed: () {},
              child: Text(
                '0778 789 987',
                style: FontConstant.bodyMediumTextStyleFont(
                  color: TezColor.blue,
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

Widget _bullet(String text, TextStyle style) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('• ', style: TextStyle(fontSize: 18)),
      Expanded(child: Text(text, style: style)),
    ],
  );
}
