part of '../home_page_detail.dart';

mixin HomePageDetailMixin {
  /// Widgets
  Row _bookInfo(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 128,
          height: 206,
          decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(
              image: NetworkImage(''.ext.randomImage),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lily'nin Maceraları",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 10.h),
              Container(
                width: 64.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    'Macera',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.defaultAppColor.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              _infoQuestion(context, text: 'okuma seviyesi'),
              SizedBox(height: 5.h),
              _infoAnswer(context, text: '1. Seviye'),
              SizedBox(height: 14.h),
              _infoQuestion(context, text: 'ortalama okuma süresi'),
              SizedBox(height: 5.h),
              _infoAnswer(context, text: '1 saat 25 dakika')
            ],
          ),
        )
      ],
    );
  }

  Text _infoAnswer(BuildContext context, {required String text}) => Text(
        text,
        style: context.general.textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );

  Text _infoQuestion(BuildContext context, {required String text}) => Text(text.toUpperCase(),
      style: context.general.textTheme.bodySmall?.copyWith(
        color: Colors.white.withAlpha(50),
        fontWeight: FontWeight.bold,
      ));

  Text _description(BuildContext context) {
    return Text(
      'Ali, Ayse, Elif ve Mehmet yedi yasina gelmis ve ilkokula baslamislardi. Küçük ve gok sirin bir okula gidiyorlardi. Hepsi ayni sinifta olan bu dört arkadas, okulun farkli bölümlerini çok merak ettikleri için, okulu birlikte gezmeye karar verdiler. Kendilerine "Okul Maceracilari" adini verdiler ve yeni yerler kesfetmek için bir plan yaptilar.',
      style: context.general.textTheme.bodySmall?.copyWith(
        color: Colors.white,
        letterSpacing: 1.4,
        height: 1.7,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Row _toolButton(
    BuildContext context, {
    required String text,
    required String assetPath,
  }) {
    return Row(
      children: [
        CircularBookIcon(
          assetPath: assetPath,
          size: 45,
        ),
        SizedBox(width: 10.w),
        Text(
          text,
          style: context.general.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
