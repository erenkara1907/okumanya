import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:okumanya/src/app/components/common/common_appbar.dart';
import 'package:okumanya/src/app/components/common/common_elevated_button.dart';
import 'package:okumanya/src/app/components/common/common_scaffold.dart';
import 'package:okumanya/src/app/components/icon/circular_book_icon.dart';
import 'package:okumanya/src/app/pages/home/bloc/reading/reading_bloc.dart';
import 'package:okumanya/src/app/pages/home/widget/reading_modal_bottom_sheet.dart';
import 'package:okumanya/src/resource/styles/app_colors.dart';

part './mixin/home_page_detail_mixin.dart';

@RoutePage()
class HomePageDetail extends StatelessWidget with HomePageDetailMixin {
  const HomePageDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isFullScreen: true,
      appBar: CommonAppBar(
        backButtonEnable: true,
        backButton: IconButton(onPressed: () => context.back(), icon: Icon(Icons.arrow_back)),
        title: "",
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bookInfo(context),
            SizedBox(height: 24.h),
            _toolButton(context, text: 'Favorilerime Ekle', assetPath: 'assets/images/my-favorites.png'),
            SizedBox(height: 16.h),
            _toolButton(context, text: 'Kitaplığıma Ekle', assetPath: 'assets/images/my-library.png'),
            SizedBox(height: 30.h),
            // GradientButton(
            //   onPressed: () {},
            //   text: 'Okumaya Başla',
            //   width: context.sized.width,
            //   height: 40.h,
            // ),
            BlocBuilder<ReadingBloc, ReadingState>(
              builder: (context, state) {
                return GradientButton(
                  onPressed: () {
                    _showReadingModal(context);
                    // Sample reading pages - replace with your actual content
                    final pages = [
                      ReadingPage(
                        title: "Bölüm 1: Başlangıç",
                        content:
                            "Hikayemiz burada başlıyor...\n\nBir zamanlar uzak bir diyarda, cesur bir kahraman yaşarmış. Bu kahraman büyük bir maceraya atılmak üzereydi.",
                      ),
                      ReadingPage(
                        title: "Bölüm 2: Yolculuk",
                        content:
                            "Yolculuk devam ediyor...\n\nKahramanımız yolda birçok zorlukla karşılaştı. Ancak kararlılığı onu her zaman ileri götürdü.",
                      ),
                      ReadingPage(
                        title: "Bölüm 3: Son",
                        content:
                            "Ve sonunda...\n\nTüm zorluklara rağmen kahramanımız hedefine ulaştı. Bu onun hayatındaki en büyük başarıydı.",
                      ),
                    ];

                    BlocProvider.of<ReadingBloc>(context).add(
                      OpenReadingModal(pages: pages),
                    );
                  },
                  text: 'Okumaya Başla',
                  width: context.sized.width,
                  height: 40.h,
                );
              },
            ),
            SizedBox(height: 28.h),
            _description(context)
          ],
        ),
      ),
    );
  }

  void _showReadingModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) => const ReadingModalBottomSheet(),
    );
  }
}
