import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:product_catalog_application/features/product/widget/product_image.dart';
import 'package:product_catalog_application/utils/context_extension.dart';

class ProductGallery extends HookWidget {
  const ProductGallery({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentIndex = useState(0);
    final hasMany = images.length > 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: PageView.builder(
                  controller: pageController,
                  itemCount: images.length,
                  onPageChanged: (index) => currentIndex.value = index,
                  itemBuilder: (context, index) => ProductImage(
                    imageUrl: images[index],
                    radius: 0,
                    iconSize: 56,
                  ),
                ),
              ),
              if (hasMany)
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: _PageBadge(
                    text: '${currentIndex.value + 1}/${images.length}',
                  ),
                ),
            ],
          ),
        ),
        if (hasMany)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 10,
              children: [
                for (var i = 0; i < images.length; i++)
                  _Thumb(
                    imageUrl: images[i],
                    selected: i == currentIndex.value,
                    onTap: () => pageController.animateToPage(
                      i,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _PageBadge extends StatelessWidget {
  const _PageBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: context.themeColor.onSurface.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: context.textTheme.labelLarge?.copyWith(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({
    required this.imageUrl,
    required this.selected,
    required this.onTap,
  });

  final String imageUrl;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? context.themeColor.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: ProductImage(imageUrl: imageUrl, radius: 10, iconSize: 20),
      ),
    );
  }
}
