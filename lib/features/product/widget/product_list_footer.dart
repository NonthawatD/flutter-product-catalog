import 'package:flutter/material.dart';
import 'package:product_catalog_application/features/product/controller/product_list_controller.dart';
import 'package:product_catalog_application/utils/context_extension.dart';

class ProductListFooter extends StatelessWidget {
  const ProductListFooter({super.key, required this.controller});

  final ProductListController controller;

  @override
  Widget build(BuildContext context) {
    final Widget content;

    if (controller.isLoadingMore) {
      // 2) กำลังโหลดหน้าถัดไป
      content = const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2.5),
      );
    } else if (controller.loadMoreErrorMessage != null) {
      // 3) โหลดหน้าถัดไปไม่สำเร็จ
      content = Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Text(
            controller.loadMoreErrorMessage!,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 14,
              color: context.themeColor.error,
            ),
          ),
          TextButton.icon(
            onPressed: controller.fetchMore,
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: Text('ลองใหม่', style: context.textTheme.labelLarge),
          ),
        ],
      );
    } else if (controller.hasMore) {
      // 1) มีหน้าถัดไป
      content = OutlinedButton(
        onPressed: controller.fetchMore,
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          side: BorderSide(color: context.themeColor.outlineVariant),
        ),
        child: Text('โหลดเพิ่มเติม', style: context.textTheme.labelLarge),
      );
    } else {
      // 4) โหลดครบทุกรายการแล้ว
      content = Text(
        'แสดงครบทุกรายการแล้ว',
        style: context.textTheme.bodySmall,
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 45),
      child: Center(child: content),
    );
  }
}
