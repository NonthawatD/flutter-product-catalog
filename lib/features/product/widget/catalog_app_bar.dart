import 'package:flutter/material.dart';
import 'package:product_catalog_application/utils/context_extension.dart';

class CatalogAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CatalogAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 56,
      automaticallyImplyLeading: false,
      backgroundColor: context.themeColor.surface,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      titleSpacing: 16,
      shape: Border(
        bottom: BorderSide(color: context.themeColor.outlineVariant),
      ),
      title: Row(
        spacing: 10,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: context.themeColor.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.grid_view_rounded, size: 18, color: Colors.white),
          ),
          Text('CatalogX', style: context.textTheme.titleLarge),
        ],
      ),
    );
  }
}
