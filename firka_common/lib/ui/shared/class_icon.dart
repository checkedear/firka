import 'package:flutter/material.dart';

import 'package:firka_common/core/icon_helper.dart';
import 'package:firka_common/ui/shared/firka_icon.dart';

import '../../core/icon_helper.dart';

class ClassIconWidget extends StatelessWidget {
  final ClassIcon? icon;
  final Color color;
  final double? size;

  ClassIconWidget({
    super.key,
    required String uid,
    required String className,
    required String category,
    this.color = Colors.white,
    this.size,
  }) : this.icon = getIconType(uid, className, category);

  @override
  Widget build(BuildContext context) {
    return FirkaIconWidget(
      FirkaIconType.majesticons,
      getIconData(icon),
      color: color,
      size: size,
    );
  }
}
