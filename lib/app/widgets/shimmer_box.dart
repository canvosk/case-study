import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:study_case/core/theme/app_colors.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.black,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
