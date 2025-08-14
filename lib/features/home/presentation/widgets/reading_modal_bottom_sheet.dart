import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:okumanya/features/home/presentation/bloc/reading/reading_bloc.dart';
import 'package:okumanya/shared/resources/styles/app_colors.dart';

class ReadingModalBottomSheet extends StatefulWidget {
  const ReadingModalBottomSheet({super.key});

  @override
  State<ReadingModalBottomSheet> createState() => _ReadingModalBottomSheetState();
}

class _ReadingModalBottomSheetState extends State<ReadingModalBottomSheet> with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value * MediaQuery.of(context).size.height),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: AppColors.defaultAppColor.primaryColor),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                children: [
                  SizedBox(height: 48.h),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.w),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                            child: BlocBuilder<ReadingBloc, ReadingState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () => _closeModal(context),
                                      icon: Icon(
                                        Icons.close,
                                        color: AppColors.defaultAppColor.primaryColor,
                                        size: 28,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: state.currentPageIndex > 0
                                              ? () {
                                                  _pageController.previousPage(
                                                    duration: const Duration(milliseconds: 300),
                                                    curve: Curves.easeInOut,
                                                  );
                                                }
                                              : null,
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            color: state.currentPageIndex > 0 ? Colors.blue : Colors.grey.shade400,
                                            size: 24,
                                          ),
                                        ),
                                        // Page indicators
                                        Text(
                                          "${state.currentPageIndex + 1}. Sayfa",
                                          style: context.general.textTheme.bodyLarge?.copyWith(
                                            color: AppColors.defaultAppColor.primaryColor,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: state.currentPageIndex < state.pages.length - 1
                                              ? () {
                                                  _pageController.nextPage(
                                                    duration: const Duration(milliseconds: 300),
                                                    curve: Curves.easeInOut,
                                                  );
                                                }
                                              : null,
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: state.currentPageIndex < state.pages.length - 1
                                                ? Colors.blue
                                                : Colors.grey.shade400,
                                            size: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () => _closeModal(context),
                                          icon: Icon(
                                            Icons.voice_chat,
                                            color: AppColors.defaultAppColor.primaryColor,
                                            size: 28,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () => _closeModal(context),
                                          icon: Icon(
                                            Icons.warning,
                                            color: AppColors.defaultAppColor.primaryColor,
                                            size: 28,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: BlocBuilder<ReadingBloc, ReadingState>(
                              builder: (context, state) {
                                return PageView.builder(
                                  controller: _pageController,
                                  physics: const ClampingScrollPhysics(),
                                  onPageChanged: (index) {
                                    BlocProvider.of<ReadingBloc>(context).add(
                                      GoToPage(pageIndex: index),
                                    );
                                  },
                                  itemCount: state.pages.length,
                                  itemBuilder: (context, index) {
                                    final page = state.pages[index];
                                    return Padding(
                                      padding: EdgeInsets.all(24.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            page.title,
                                            style: TextStyle(
                                              fontSize: 24.w,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: 24.h),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Text(
                                                page.content,
                                                style: TextStyle(
                                                  fontSize: 16.w,
                                                  height: 1.6,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _closeModal(BuildContext context) {
    _animationController.reverse().then((_) {
      BlocProvider.of<ReadingBloc>(context).add(CloseReadingModal());
      Navigator.of(context).pop();
    });
  }
}
