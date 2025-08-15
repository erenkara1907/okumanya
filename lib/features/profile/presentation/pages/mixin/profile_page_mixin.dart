part of '../profile_page.dart';

mixin ProfilePageMixin {
  /// Variables
  late TabController tabController;

  /// Widgets
  Transform _tabbar() {
    return Transform.translate(
      offset: Offset(-20.w, 0),
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorColor: Colors.white,
        indicatorWeight: 2,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.white,
        unselectedLabelColor: Color(0xff12A4B8),
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        tabs: [
          Tab(text: "profile.agenda".tr()),
          Tab(text: "profile.goals".tr()),
          Tab(text: "profile.reviews".tr()),
          Tab(text: "profile.friends".tr()),
          Tab(text: "profile.statistics".tr()),
        ],
      ),
    );
  }

  SingleChildScrollView agenda(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bookInfo(context),
          SizedBox(height: 30.h),
          _bookInfo(context),
        ],
      ),
    );
  }

  Row _bookInfo(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 250,
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
              SizedBox(height: 7.h),
              LinearPercentIndicator(
                padding: EdgeInsets.zero,
                lineHeight: 20,
                barRadius: Radius.circular(4),
                width: 100,
                backgroundColor: Colors.white,
                percent: 0.5,
                progressColor: Color(0xffFFC52F),
                center: Text(
                  '%50 Okundu',
                  style: context.general.textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.defaultAppColor.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              _infoQuestion(context, text: 'son okuduğum sayfa'),
              SizedBox(height: 5.h),
              _infoAnswer(context, text: '12. Sayfa', totalBookPages: '58'),
              SizedBox(height: 14.h),
              _infoQuestion(context, text: 'okuma seviyesi'),
              SizedBox(height: 5.h),
              _infoAnswer(context, text: '1. Seviye'),
              SizedBox(height: 13.h),
              GradientButton(
                text: 'Okumaya Devam Et',
                height: 40,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _infoAnswer(BuildContext context,
          {required String text, String? totalBookPages}) =>
      totalBookPages != null
          ? RichText(
              text: TextSpan(children: [
              TextSpan(
                text: text,
                style: context.general.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' / $totalBookPages',
                style: context.general.textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]))
          : Text(
              text,
              style: context.general.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );

  Text _infoQuestion(BuildContext context, {required String text}) =>
      Text(text.toUpperCase(),
          style: context.general.textTheme.bodySmall?.copyWith(
            color: Colors.white.withAlpha(50),
            fontWeight: FontWeight.bold,
          ));
}
