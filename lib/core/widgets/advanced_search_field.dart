import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Advanced search field with debouncing and enhanced UX
class AdvancedSearchField extends StatefulWidget {
  const AdvancedSearchField({
    super.key,
    this.hintText = 'Search...',
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.debounceDelay = AppConstants.searchDebounce,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.borderRadius = AppConstants.defaultRadius,
    this.showBorder = false,
    this.autofocus = false,
    this.enabled = true,
    this.controller,
  });

  final String hintText;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onSearchSubmitted;
  final Duration debounceDelay;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final double borderRadius;
  final bool showBorder;
  final bool autofocus;
  final bool enabled;
  final TextEditingController? controller;

  @override
  State<AdvancedSearchField> createState() => _AdvancedSearchFieldState();
}

class _AdvancedSearchFieldState extends State<AdvancedSearchField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  String _previousValue = '';

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();

    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final currentValue = _controller.text;

    if (currentValue != _previousValue) {
      _previousValue = currentValue;

      // Debounce the search
      Future.delayed(widget.debounceDelay, () {
        if (mounted && _controller.text == currentValue) {
          widget.onSearchChanged?.call(currentValue);
        }
      });
    }
  }

  void _clearSearch() {
    _controller.clear();
    widget.onSearchChanged?.call('');
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: widget.showBorder
            ? Border.all(
                color: colorScheme.outline.withValues(alpha: 0.3),
                width: 1,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        autofocus: widget.autofocus,
        enabled: widget.enabled,
        onSubmitted: widget.onSearchSubmitted,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
            vertical: 14,
          ),
          prefixIcon: widget.prefixIcon ??
              Icon(
                Icons.search_rounded,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
                size: 20,
              ),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  onPressed: _clearSearch,
                  icon: Icon(
                    Icons.clear_rounded,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                    size: 20,
                  ),
                  visualDensity: VisualDensity.compact,
                )
              : widget.suffixIcon,
        ),
      ),
    );
  }
}
