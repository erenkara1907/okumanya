import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../../shared/resources/styles/app_themes.dart';

class Shimmer extends StatefulWidget {
  const Shimmer({
    this.child,
    super.key,
  });

  final Widget? child;
  // ignore: library_private_types_in_public_api
  static _ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<_ShimmerState>();
  }

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late bool _isDarkTheme;

  static const _shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  static const _shimmerDarkGradient = LinearGradient(
    colors: [
      Color(0xFF1A1A1A),
      Color(0xFF2C2C2C),
      Color(0xFF1A1A1A),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  LinearGradient get gradient {
    final sourceGradient =
        _isDarkTheme ? _shimmerDarkGradient : _shimmerGradient;
    return LinearGradient(
      colors: sourceGradient.colors,
      stops: sourceGradient.stops,
      begin: sourceGradient.begin,
      end: sourceGradient.end,
      transform:
          _SlidingGradientTransform(slidePercent: _shimmerController.value),
    );
  }

  bool get isSized => (context.findRenderObject() as RenderBox).hasSize;

  Size get size => (context.findRenderObject() as RenderBox).size;
  Listenable get shimmerChanges => _shimmerController;

  @override
  void initState() {
    super.initState();

    // Cache theme type to avoid repeated checks
    _isDarkTheme = AppThemeSetting.currentAppThemeType == AppThemeType.dark;

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000)); // Custom shimmer animation duration
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox?;

    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
