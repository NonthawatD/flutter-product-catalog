import 'package:flutter/material.dart';
import 'package:product_catalog_application/utils/context_extension.dart';

class DetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DetailAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

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
          InkResponse(
            onTap: () => Navigator.maybePop(context),
            radius: 22,
            child: Icon(
              Icons.arrow_back,
              size: 24,
              color: context.themeColor.onSurface,
            ),
          ),
          Text(
            'รายละเอียดสินค้า',
            style: context.textTheme.titleSmall?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
