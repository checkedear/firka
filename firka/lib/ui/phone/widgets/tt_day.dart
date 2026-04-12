import 'package:kreta_api/kreta_api.dart';
import 'package:firka/core/extensions.dart';
import 'package:firka/ui/components/firka_card.dart';
import 'package:firka/app/app_state.dart';
import 'package:firka/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:majesticons_flutter/majesticons_flutter.dart';

import 'lesson.dart';

class TimeTableDayWidget extends StatelessWidget {
  final AppInitialization data;
  final DateTime date;
  final List<Lesson> week;
  final List<Lesson> lessons;
  final List<Lesson> events;
  final List<Test> tests;
  final List<Lesson> day;

  const TimeTableDayWidget(
    this.data,
    this.date,
    this.week,
    this.lessons,
    this.events,
    this.tests,
    this.day, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget ttBody;

    if (lessons.isEmpty) {
      ttBody = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/logos/dave.svg",
            width: 48,
            height: 48,
          ),
          SizedBox(height: 12),
          Text(
            data.l10n.tt_no_classes_l1,
            style: appStyle.fonts.B_16R.apply(
              color: appStyle.colors.textSecondary,
            ),
          ),
          Text(
            data.l10n.tt_no_classes_l2,
            style: appStyle.fonts.B_16R.apply(
              color: appStyle.colors.textSecondary,
            ),
          ),
          if (events.isNotEmpty)
            ...events.map(
              (event) => Center(
                child: Text(
                  event.name.replaceAll(" (Nem órarendi nap)", ""),
                  style: appStyle.fonts.B_16R.apply(
                    color: appStyle.colors.textSecondary,
                  ),
                ),
              ),
            ),
        ],
      );
    } else {
      List<Widget> ttLessons = List.empty(growable: true);
      for (var i = 0; i < events.length; i++) {
        var event = events[i];
        ttLessons.add(
          FirkaCard(
            left: [
              Text(
                event.name,
                style: appStyle.fonts.B_16R.apply(
                  color: appStyle.colors.textPrimary,
                ),
              ),
            ],
          ),
        );
      }
      for (var i = 0; i < lessons.length; i++) {
        var lesson = lessons[i];
        Lesson? nextLesson = lessons.length > i + 1 ? lessons[i + 1] : null;
        ttLessons.add(
          LessonWidget(
            data,
            week,
            day,
            lessons.getLessonNo(lesson),
            lesson,
            tests.firstWhereOrNull(
              (test) => test.lessonNumber == lesson.lessonNumber,
            ),
            nextLesson,
          ),
        );
      }

      ttBody = Padding(
        padding: const EdgeInsets.only(top: 70 + 16 + 20, left: 4, right: 4),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [...ttLessons, SizedBox(height: 55)],
          ),
        ),
      );
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.1,
      child: ttBody,
    );
  }
}
