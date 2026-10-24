import 'package:flutter/material.dart';
import 'package:product_catalog_application/utils/context_extension.dart';
import 'package:product_catalog_application/widgets/state_message_view.dart';

class ErrorStateView extends StatelessWidget {
  const ErrorStateView({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return StateMessageView(
      icon: Icons.wifi_off_rounded,
      iconColor: context.themeColor.error,
      circleColor: context.themeColor.errorContainer,
      title: 'เกิดข้อผิดพลาด',
      message: message,
      onRetry: onRetry,
    );
  }
}