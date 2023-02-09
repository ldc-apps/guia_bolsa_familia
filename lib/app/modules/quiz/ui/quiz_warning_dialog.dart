import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/loading.dart';
import 'package:aid_brazil/app/modules/quiz/quiz_model.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class QuizWarningDialog extends StatelessWidget {
  final QuizWarning warning;

  const QuizWarningDialog(this.warning, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            child: CachedNetworkImage(
              imageUrl:
                  'https://ldcapps.com/wp-content/uploads/2022/11/mulher-segurando-cartao-auxilio-brasil.jpg',
              placeholder: (context, url) => const Loading(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Atenção',
                style: AppTheme.title,
              ),
              const H(24),
              Text(warning.description,
                  style: AppTheme.subtitle.copyWith(fontSize: 18)),
              const H(24),
            ],
          ),
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.greenLight,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Continuar resposndendo ao questionário.',
                    style: AppTheme.title.copyWith(fontSize: 18),
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                      color: AppColors.greenDark,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColors.greenLight,
                    size: 24,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
