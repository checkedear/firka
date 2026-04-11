import 'package:firka/app/app_state.dart';
import 'package:firka/core/extensions.dart';
import 'package:firka/ui/components/common_bottom_sheets.dart';
import 'package:firka_common/firka_common.dart';
import 'package:firka_common/ui/components/grade.dart';
import 'package:flutter/cupertino.dart';
import 'package:kreta_api/kreta_api.dart';
import 'package:majesticons_flutter/majesticons_flutter.dart';

class GradeCard extends StatelessWidget {
  final Grade grade;
  final void Function()? onTap;

  const GradeCard(this.grade, {this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: FirkaCard(
        left: [
          SizedBox(width: 8),
          GradeWidget(grade),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (grade.topic ?? grade.type.description!).firstUpper(),
                  style: appStyle.fonts.B_16SB.apply(
                    color: appStyle.colors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                grade.mode?.description != null
                    ? Text(
                        grade.mode!.description!.firstUpper(),
                        style: appStyle.fonts.B_16R.apply(
                          color: appStyle.colors.textSecondary,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      onTap: () {
        onTap == null
            ? showGradeBottomSheet(context, initData, grade)
            : onTap!.call();
      },
    );
  }
}
