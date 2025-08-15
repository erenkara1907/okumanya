import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../theme/app_theme.dart';

/// Advanced error widget with different types and actions
class AdvancedErrorWidget extends StatelessWidget {
  const AdvancedErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.type = ErrorType.generic,
    this.showIcon = true,
    this.actionText = 'Retry',
  });

  final String message;
  final VoidCallback? onRetry;
  final ErrorType type;
  final bool showIcon;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _getErrorColor(type).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getErrorIcon(type),
                size: 40,
                color: _getErrorColor(type),
              ),
            ),
            const SizedBox(height: AppConstants.defaultPadding),
          ],
          Text(
            _getErrorTitle(type),
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: AppConstants.largePadding),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(_getRetryIcon(type)),
                label: Text(actionText),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getErrorColor(type),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.smallPadding + 4),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getErrorColor(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return AppTheme.warningColor;
      case ErrorType.server:
        return AppTheme.errorColor;
      case ErrorType.notFound:
        return AppTheme.infoColor;
      case ErrorType.generic:
        return AppTheme.textSecondary;
    }
  }

  IconData _getErrorIcon(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return Icons.wifi_off_rounded;
      case ErrorType.server:
        return Icons.error_outline_rounded;
      case ErrorType.notFound:
        return Icons.search_off_rounded;
      case ErrorType.generic:
        return Icons.warning_amber_rounded;
    }
  }

  IconData _getRetryIcon(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return Icons.refresh_rounded;
      case ErrorType.server:
        return Icons.refresh_rounded;
      case ErrorType.notFound:
        return Icons.search_rounded;
      case ErrorType.generic:
        return Icons.refresh_rounded;
    }
  }

  String _getErrorTitle(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return 'Connection Problem';
      case ErrorType.server:
        return 'Server Error';
      case ErrorType.notFound:
        return 'Not Found';
      case ErrorType.generic:
        return 'Something went wrong';
    }
  }
}

enum ErrorType {
  network,
  server,
  notFound,
  generic,
}
