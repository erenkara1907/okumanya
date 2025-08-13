import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:okumanya/src/app/components/common/common_elevated_button.dart';
import 'package:okumanya/src/resource/styles/app_colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../components/common/common_appbar.dart';
import '../../../components/common/common_scaffold.dart';
import '../bloc/profile_bloc.dart';

part './mixin/profile_page_mixin.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin, ProfilePageMixin {
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isFullScreen: true,
      appBar: const CommonAppBar(
        backButtonEnable: false,
        title: "",
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.success) {}
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  "profile.title".tr(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                _tabbar(),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      agenda(context),
                      Center(child: Text("Hedeflerim İçeriği")),
                      Center(child: Text("Puan & Yorumlarım İçeriği")),
                      Center(child: Text("Arkadaşlarım İçeriği")),
                      Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _statisticInfo(
                              context,
                              question: 'toplam okuma süresi',
                              answer: '325 Saat 21 Dakika 15 Saniye',
                              assetPath: 'assets/images/total-time.png',
                            ),
                            SizedBox(height: 30.h),
                            _statisticInfo(
                              context,
                              question: 'okuduğum kitaplar',
                              answer: '20 Kitap',
                              assetPath: 'assets/images/books-read.png',
                            ),
                            SizedBox(height: 30.h),
                            _statisticInfo(
                              context,
                              question: 'dinlediğim kitaplar',
                              answer: '15 Kitap',
                              assetPath: 'assets/images/books-listen.png',
                            ),
                            SizedBox(height: 30.h),
                            _statisticInfo(
                              context,
                              question: 'ortalama okuma hızı',
                              answer: '1 Dakikada 80 Kelime',
                              assetPath: 'assets/images/read-speed.png',
                            ),
                            SizedBox(height: 30.h),
                            _statisticInfo(
                              context,
                              question: 'okumanya sıralamam',
                              answer: '13',
                              totalUserCount: '98',
                              assetPath: 'assets/images/arrangement.png',
                            ),
                            SizedBox(height: 30.h),
                            _statisticInfo(
                              context,
                              question: 'puanlarım',
                              answer: '2500',
                              assetPath: 'assets/images/point.png',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Row _statisticInfo(
    BuildContext context, {
    required String question,
    required String answer,
    required String assetPath,
    String? totalUserCount,
  }) {
    return Row(
      children: [
        Image.asset(assetPath),
        SizedBox(width: 15.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoQuestion(context, text: question),
            SizedBox(height: 1.h),
            _infoAnswer(context, text: answer, totalBookPages: totalUserCount),
          ],
        )
      ],
    );
  }
}
