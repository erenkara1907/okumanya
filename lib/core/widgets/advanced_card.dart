import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Advanced card component with enhanced design and functionality
class AdvancedCard extends StatefulWidget {
  const AdvancedCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppConstants.defaultPadding),
    this.margin = const EdgeInsets.all(AppConstants.smallPadding),
    this.elevation = AppConstants.cardElevation,
    this.borderRadius = AppConstants.defaultRadius,
    this.backgroundColor,
    this.shadowColor,
    this.onTap,
    this.onLongPress,
    this.gradient,
    this.border,
    this.isAnimated = true,
    this.animationDuration = AppConstants.shortAnimation,
    this.hoverElevation = 4,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double elevation;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? shadowColor;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Gradient? gradient;
  final BoxBorder? border;
  final bool isAnimated;
  final Duration animationDuration;
  final double hoverElevation;

  @override
  State<AdvancedCard> createState() => _AdvancedCardState();
}

class _AdvancedCardState extends State<AdvancedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _elevationAnimation;
  // Removed unused variable _isHovered

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _elevationAnimation = Tween<double>(
      begin: widget.elevation,
      end: widget.hoverElevation,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleHoverEnter() {
    if (!widget.isAnimated) return;
    _animationController.forward();
  }

  void _handleHoverExit() {
    if (!widget.isAnimated) return;
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: widget.margin,
      child: MouseRegion(
        onEnter: (_) => _handleHoverEnter(),
        onExit: (_) => _handleHoverExit(),
        child: AnimatedBuilder(
          animation: _elevationAnimation,
          builder: (context, child) {
            return Material(
              elevation: widget.isAnimated
                  ? _elevationAnimation.value
                  : widget.elevation,
              shadowColor: widget.shadowColor ?? theme.shadowColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? theme.cardColor,
                  gradient: widget.gradient,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: widget.border,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: widget.onTap,
                      onLongPress: widget.onLongPress,
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      splashColor: theme.primaryColor.withValues(alpha: 0.1),
                      highlightColor:
                          theme.primaryColor.withValues(alpha: 0.05),
                      child: Container(
                        padding: widget.padding,
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
