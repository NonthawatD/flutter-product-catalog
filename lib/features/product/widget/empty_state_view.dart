import 'package:flutter/material.dart';
import 'package:product_catalog_application/utils/context_extension.dart';
import 'package:product_catalog_application/widgets/state_message_view.dart';

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({super.key, required this.onRefresh});

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: StateMessageView(
              icon: Icons.inbox_outlined,
              iconColor: context.themeColor.onSurfaceVariant.withValues(alpha: 0.7),
              circleColor: context.themeColor.surfaceContainer,
              title: 'ไม่พบสินค้า',
              message: 'ลองดึงหน้าจอลงเพื่อรีเฟรช',
            ),
          ),
        ),
      ),
    );
  }
}
