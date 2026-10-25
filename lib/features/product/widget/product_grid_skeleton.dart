import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:product_catalog_application/features/product/widget/product_card_skeleton.dart';
import 'package:product_catalog_application/features/product/widget/product_grid_delegate.dart';
import 'package:product_catalog_application/widgets/skeleton_box.dart';

class ProductGridSkeleton extends HookWidget {
  const ProductGridSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.sizeOf(context).width < 600 ? 16.0 : 24.0;

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 900),
    );
    useEffect(() {
      animationController.repeat(reverse: true);
      return null;
    }, []);

    return FadeTransition(
      opacity: Tween<double>(begin: 0.4, end: 1).animate(animationController),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            const SkeletonBox(
              width: 120,
              height: 12,
            ), 
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: productGridDelegate(context),
                itemCount: 12,
                itemBuilder: (context, index) => const ProductCardSkeleton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
