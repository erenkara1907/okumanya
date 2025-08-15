import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Advanced loading widget with different states and animations
class AdvancedLoading extends StatelessWidget {
  const AdvancedLoading({
    super.key,
    this.type = LoadingType.circular,
    this.size = 40.0,
    this.color,
    this.message,
    this.showBackground = true,
  });

  final LoadingType type;
  final double size;
  final Color? color;
  final String? message;
  final bool showBackground;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final loadingWidget = _buildLoadingWidget(theme);

    if (message != null) {
      return _buildWithMessage(loadingWidget, theme);
    }

    if (showBackground) {
      return Container(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        decoration: BoxDecoration(
          color: colorScheme.surface.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
        child: loadingWidget,
      );
    }

    return loadingWidget;
  }

  Widget _buildLoadingWidget(ThemeData theme) {
    final loadingColor = color ?? theme.colorScheme.primary;

    switch (type) {
      case LoadingType.circular:
        return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            color: loadingColor,
            strokeWidth: 3,
          ),
        );

      case LoadingType.linear:
        return SizedBox(
          width: size * 2,
          height: 4,
          child: LinearProgressIndicator(
            color: loadingColor,
            backgroundColor: loadingColor.withValues(alpha: 0.2),
          ),
        );

      case LoadingType.dots:
        return _DotsLoading(
          color: loadingColor,
          size: size / 8,
        );

      case LoadingType.pulse:
        return _PulseLoading(
          color: loadingColor,
          size: size,
        );

      case LoadingType.wave:
        return _WaveLoading(
          color: loadingColor,
          size: size,
        );
    }
  }

  Widget _buildWithMessage(Widget loadingWidget, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: showBackground
          ? BoxDecoration(
              color: theme.colorScheme.surface.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(AppConstants.defaultPadding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            )
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          loadingWidget,
          const SizedBox(height: AppConstants.defaultPadding),
          Text(
            message!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

enum LoadingType {
  circular,
  linear,
  dots,
  pulse,
  wave,
}

/// Dots loading animation
class _DotsLoading extends StatefulWidget {
  const _DotsLoading({
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  State<_DotsLoading> createState() => _DotsLoadingState();
}

class _DotsLoadingState extends State<_DotsLoading>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 600), // Custom animation duration
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    _startAnimations();
  }

  void _startAnimations() {
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: widget.size / 4),
              child: Opacity(
                opacity: 0.3 + (_animations[index].value * 0.7),
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

/// Pulse loading animation
class _PulseLoading extends StatefulWidget {
  const _PulseLoading({
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  State<_PulseLoading> createState() => _PulseLoadingState();
}

class _PulseLoadingState extends State<_PulseLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000), // Custom animation duration
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color:
                widget.color.withValues(alpha: 0.3 + (_animation.value * 0.7)),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}

/// Wave loading animation
class _WaveLoading extends StatefulWidget {
  const _WaveLoading({
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  State<_WaveLoading> createState() => _WaveLoadingState();
}

class _WaveLoadingState extends State<_WaveLoading>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      5,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    _startAnimations();
  }

  void _startAnimations() {
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: widget.size / 20),
              width: widget.size / 8,
              height: widget.size / 2 +
                  (_animations[index].value * widget.size / 2),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(widget.size / 16),
              ),
            );
          },
        );
      }),
    );
  }
}
