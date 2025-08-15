import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../advanced_search_field.dart';
import '../../monitoring/app_monitor.dart';
import '../../../shared/di/service_locator.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    this.title,
    this.backButtonEnable = false,
    this.backButton,
    this.action,
    this.onSearchChanged,
    this.showSearch = true,
  });

  final String? title;
  final bool? backButtonEnable;
  final Widget? action;
  final Widget? backButton;
  final ValueChanged<String>? onSearchChanged;
  final bool showSearch;

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CommonAppBarState extends State<CommonAppBar>
    with TickerProviderStateMixin {
  bool _isSearchExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearchExpanded = !_isSearchExpanded;
    });

    if (_isSearchExpanded) {
      _animationController.forward();
      // Track search opened
      final appMonitor = getIt<AppMonitor>();
      appMonitor.trackUserInteraction(
        'search_opened',
        screen: 'CommonAppBar',
        element: 'search_icon',
      );
    } else {
      _animationController.reverse();
      _searchController.clear();
      widget.onSearchChanged?.call('');
      // Track search closed
      final appMonitor = getIt<AppMonitor>();
      appMonitor.trackUserInteraction(
        'search_closed',
        screen: 'CommonAppBar',
        element: 'search_close',
      );
    }
  }

  void _onSearchChanged(String query) {
    widget.onSearchChanged?.call(query);
    // Track search query
    final appMonitor = getIt<AppMonitor>();
    appMonitor.trackUserInteraction(
      'search_query',
      screen: 'CommonAppBar',
      element: 'search_field',
      additionalData: {
        'query_length': query.length,
        'has_query': query.isNotEmpty,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: !_isSearchExpanded,
      title: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Row(
            children: [
              // Logo - fade out when search is expanded
              if (!_isSearchExpanded || _fadeAnimation.value < 0.5)
                Opacity(
                  opacity: 1.0 - _fadeAnimation.value,
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: kToolbarHeight * 0.75,
                  ),
                ),

              // Expanded search field
              if (_isSearchExpanded)
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-1.0, 0.0),
                        end: Offset.zero,
                      ).animate(_animationController),
                      child: AdvancedSearchField(
                        controller: _searchController,
                        hintText: 'Kitap, yazar ara...',
                        onSearchChanged: _onSearchChanged,
                        autofocus: true,
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        borderRadius: 25,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white70,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: widget.backButtonEnable != false
          ? widget.backButton
          : Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Image.asset(
                'assets/images/book2.png',
              ),
            ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: Row(
            children: [
              // Search button with animation
              if (widget.showSearch)
                GestureDetector(
                  onTap: _toggleSearch,
                  child: AnimatedRotation(
                    turns: _isSearchExpanded ? 0.125 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _isSearchExpanded
                            ? Colors.white.withValues(alpha: 0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: _isSearchExpanded
                          ? const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            )
                          : Image.asset(
                              'assets/images/search-normal.png',
                              width: 24,
                              height: 24,
                            ),
                    ),
                  ),
                ),

              if (widget.showSearch) const SizedBox(width: 20),

              // Notification icon - fade out when search is expanded
              AnimatedOpacity(
                opacity: _isSearchExpanded ? 0.3 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () {
                    // Track notification tap
                    final appMonitor = getIt<AppMonitor>();
                    appMonitor.trackUserInteraction(
                      'notification_tap',
                      screen: 'CommonAppBar',
                      element: 'notification_icon',
                    );
                  },
                  child: Image.asset(
                    'assets/images/notification.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
