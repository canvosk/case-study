import 'package:flutter/material.dart';
import 'package:study_case/core/theme/app_colors.dart';

TextStyle? detailRating(BuildContext context) =>
    Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: AppColor.textColor.withOpacity(0.8),
        );

TextStyle? detailTitle(BuildContext context) =>
    Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: AppColor.textColor,
        );

TextStyle? productNameText(BuildContext context) =>
    Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColor.textColor,
        );
