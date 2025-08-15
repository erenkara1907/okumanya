import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:okumanya/core/localization/locale_keys.dart';
import 'package:okumanya/shared/navigation/routes/app_router.gr.dart';
import 'package:okumanya/shared/resources/styles/app_colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/widgets/common/common_appbar.dart';
import '../../../../core/widgets/common/common_scaffold.dart';
import '../../../../core/widgets/shimmer/shimmer_placeholder.dart';
import '../../../../core/analytics/analytics_service.dart';
import '../../../../core/performance/performance_service.dart';
import '../../../../core/monitoring/app_monitor.dart';
import '../../../../shared/di/service_locator.dart';
import '../bloc/home/home_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchTextEditingController = TextEditingController();
  late AnalyticsService _analyticsService;
  late PerformanceService _performanceService;
  late AppMonitor _appMonitor;

  @override
  void initState() {
    super.initState();
    _analyticsService = getIt<AnalyticsService>();
    _performanceService = getIt<PerformanceService>();
    _appMonitor = getIt<AppMonitor>();

    // Track screen view
    _analyticsService.trackScreen('HomePage');
    _appMonitor.trackUserInteraction('screen_view', screen: 'HomePage');

    // Track page load performance
    _performanceService.startMeasurement('home_page_init');
  }

  @override
  void dispose() {
    searchTextEditingController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _appMonitor.trackUserInteraction(
      'search_performed',
      screen: 'HomePage',
      element: 'search_field',
      additionalData: {
        'query': query.isNotEmpty ? 'has_query' : 'empty_query',
        'query_length': query.length,
      },
    );

    // TODO: Implement actual search functionality with BLoC
    // context.read<HomeBloc>().add(SearchBooks(query: query));

    if (query.isNotEmpty) {
      _analyticsService.trackEvent('book_search', parameters: {
        'search_query_length': query.length,
        'search_source': 'app_bar',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isFullScreen: true,
      appBar: CommonAppBar(
        title: "",
        onSearchChanged: _onSearchChanged,
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStatus.success) {
            // End performance measurement when data loads
            _performanceService.endMeasurement('home_page_init');

            // Track successful data load
            _analyticsService.trackEvent('home_data_loaded', parameters: {
              'books_count': state.books.length,
              'categories_count': state.categories.length,
            });
          } else if (state.status == HomeStatus.error) {
            // Track error state
            _analyticsService.recordError(
              Exception(state.errorMessage),
              null,
              reason: 'home_data_load_failed',
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 24.h,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Track filter interaction
                      _appMonitor.trackUserInteraction(
                        'filter_tap',
                        screen: 'HomePage',
                        element: 'filter_button',
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          LocaleKeys.home.filter,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(width: 10.w),
                        Image.asset(
                          "assets/images/filter-search.png",
                          width: 24,
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.home.library,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(height: 14.h),
                    SizedBox(
                      height: 206.h,
                      child: state.status.isLoading
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return const BookCardShimmer();
                              },
                            )
                          : ListView.builder(
                              key: const ValueKey('library_books'),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 5,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 14),
                                  child: BookWidget(
                                    key: ValueKey('library_book_$index'),
                                    image: "assets/images/book3.png",
                                    percent: 0.2,
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.home.science,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(height: 14.h),
                    SizedBox(
                      height: 206.h,
                      child: ListView.builder(
                        key: const ValueKey('science_books_1'),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 5,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: BookWidget(
                              key: ValueKey('science_book_1_$index'),
                              image: "assets/images/book4.png",
                              percent: 0.8,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.home.science,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(height: 14.h),
                    SizedBox(
                      height: 206.h,
                      child: ListView.builder(
                        key: const ValueKey('science_books_2'),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 5,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: BookWidget(
                              key: ValueKey('science_book_2_$index'),
                              image: "assets/images/book4.png",
                              percent: 0.8,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BookWidget extends StatelessWidget {
  const BookWidget({
    super.key,
    required this.image,
    required this.percent,
  });

  final String image;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Track book interaction
        final appMonitor = getIt<AppMonitor>();
        appMonitor.trackUserInteraction(
          'book_tap',
          screen: 'HomePage',
          element: 'BookWidget',
          additionalData: {
            'book_image': image,
            'progress_percent': percent,
          },
        );
        context.pushRoute(HomeRouteDetail());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              LinearPercentIndicator(
                width: 112.w,
                lineHeight: 7.0,
                percent: 1,
                progressColor: Colors.white,
                barRadius: Radius.circular(8.r),
              ),
              Row(
                children: [
                  const SizedBox(width: 1),
                  LinearPercentIndicator(
                    width: 110.w,
                    lineHeight: 6.0,
                    percent: percent,
                    progressColor: AppColors.defaultAppColor.primaryColor,
                    backgroundColor: Colors.white,
                    barRadius: Radius.circular(8.r),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
