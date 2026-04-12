import 'package:firka/ui/components/firka_card.dart';
import 'package:firka/ui/theme/style.dart';
import 'package:flutter/material.dart';

import 'package:kreta_api/kreta_api.dart';
import 'package:majesticons_flutter/majesticons_flutter.dart';

// TODO: Finish
class InfoBoardItemWidget extends StatelessWidget {
  final InfoBoardItem item;

  const InfoBoardItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return FirkaCard(
      left: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          height: 32,
          width: 32,
          decoration: ShapeDecoration(
            color: appStyle.colors.accent,
            shape: CircleBorder(
              eccentricity: 1,
              // borderRadius: BorderRadius.circular(6)),
            ),
          ),
          child: Center(
            child: Text(
              item.author[0],
              style: appStyle.fonts.H_18px.copyWith(
                fontSize: 22,
                color: appStyle.colors.textPrimary,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overflow: TextOverflow.ellipsis,
                item.title.trim(),
                style: appStyle.fonts.B_16SB.apply(
                  color: appStyle.colors.textPrimary,
                ),
              ),
              Text(
                item.author,
                style: appStyle.fonts.B_16R.apply(
                  color: appStyle.colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
