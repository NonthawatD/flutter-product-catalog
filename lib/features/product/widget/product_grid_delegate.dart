import 'package:flutter/material.dart';

SliverGridDelegate productGridDelegate(BuildContext context) {
  final isTablet = MediaQuery.sizeOf(context).width >= 600;

  return SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 260,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    mainAxisExtent: isTablet ? 340 : 267,
  );
}