import 'package:flutter/material.dart';
import 'package:product_catalog_application/utils/context_extension.dart';

class StateMessageView extends StatelessWidget {
  const StateMessageView({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.circleColor,
    required this.title,
    required this.message,
    this.onRetry,
  });

  final IconData icon;
  final Color iconColor;
  final Color circleColor;
  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: iconColor),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.headlineSmall,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.copyWith(fontSize: 14),
            ),
            if (onRetry != null)
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: Text(
                  'ลองใหม่',
                  style: context.textTheme.labelLarge?.copyWith(
                    color: context.themeColor.onPrimary,
                  ),
                ),
                style: FilledButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
