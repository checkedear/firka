import 'package:kreta_api/kreta_api.dart';
import 'package:firka/core/extensions.dart';
import 'package:firka/ui/components/firka_card.dart';
import 'package:firka/l10n/app_localizations.dart';
import 'package:firka/ui/theme/style.dart';
import 'package:firka/ui/shared/firka_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:majesticons_flutter/majesticons_flutter.dart';

import 'package:firka/ui/shared/class_icon.dart';

class LessonBigWidget extends StatelessWidget {
  final AppLocalizations l10n;
  final DateTime now;
  final int? lessonNo;
  final Lesson? lesson;
  final Lesson? prevLesson;
  final Lesson? nextLesson;
  final List<Lesson> lessons;
  final List<Test> tests;

  const LessonBigWidget(
    this.l10n,
    this.now,
    this.lessonNo,
    this.lesson,
    this.prevLesson,
    this.nextLesson,
    this.lessons,
    this.tests, {
    super.key,
  });

  String timeLeftl10n() {
    var timeLeft = nextLesson!.start.difference(now);

    var minsLeft = timeLeft.inMinutes;
    var secsLeft = timeLeft.inSeconds;

    var timeLeftStr =
        "$minsLeft ${minsLeft == 1 ? l10n.starting_min : l10n.starting_min_plural}";
    if (minsLeft < 1) {
      timeLeftStr =
          "$secsLeft ${secsLeft == 1 ? l10n.starting_sec : l10n.starting_sec_plural}";
    }

    return timeLeftStr;
  }

  Widget _buildProgressBar(BuildContext context, double percent) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: percent,
        backgroundColor: appStyle.colors.a15p,
        color: appStyle.colors.accent,
        minHeight: 8,
      ),
    );
  }

  Widget _buildAfterLessons(BuildContext context) {
    // TODO: holnapi órák száma kiszámolás
    var lessonsTomorrow = 0;

    var testsTomorrow = tests
        .where(
          (test) =>
              test.date.isAfter(now.getMidnight().add(Duration(days: 1))) &&
              test.date.isBefore(now.add(Duration(days: 2))),
        )
        .length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FirkaCard(
          left: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Stack(
                        children: [
                          Card(
                            shadowColor: Colors.transparent,
                            color: appStyle.colors.a15p,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(6),
                              child: FirkaIconWidget(
                                FirkaIconType.majesticons,
                                Majesticon.moonSolid,
                                size: 32.0,
                                color: appStyle.colors.accent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      testsTomorrow == 0
                          ? l10n.tt_no_classes_l2
                          : l10n.get_ready,
                      style: appStyle.fonts.B_16R.apply(
                        color: appStyle.colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
          extra: Column(
            children: [
              SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: Container(
                  width: double.infinity,
                  color: appStyle.colors.background,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(2),
                              child: FirkaIconWidget(
                                FirkaIconType.majesticons,
                                Majesticon.editPen4Solid,
                                size: 32.0,
                                color: appStyle.colors.accent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        (lessonsTomorrow == 0 && testsTomorrow == 0)
                            ? l10n.no_tests_tomorrow
                            : (testsTomorrow > 1)
                            ? l10n.tests_tomorrow(testsTomorrow.toString())
                            : (testsTomorrow < 1 && lessonsTomorrow > 0)
                            ? l10n.lessons_tomorrow(lessonsTomorrow.toString())
                            : l10n.tests_tomorrow(testsTomorrow.toString()),
                        textAlign: TextAlign.left,
                        style: appStyle.fonts.B_16R.apply(
                          color: appStyle.colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNoLessons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FirkaCard(
          left: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Card(
                      shadowColor: Colors.transparent,
                      color: appStyle.colors.a15p,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: FirkaIconWidget(
                          FirkaIconType.majesticonsLocal,
                          'cupFilled',
                          color: appStyle.colors.accent,
                          size: 24,
                        ),
                      ),
                    ),
                    Text(
                      l10n.breakTxt,
                      style: appStyle.fonts.B_16SB.apply(
                        color: appStyle.colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOnLesson(BuildContext context) {
    var duration = lesson!.end.difference(lesson!.start).inMilliseconds;
    var progress = now.difference(lesson!.start).inMilliseconds;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FirkaCard(
          left: [
            Row(
              children: [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/subtract.svg",
                        color: appStyle.colors.a15p,
                        width: 18,
                        height: 18,
                      ),
                      Center(
                        child: Text(
                          lesson?.lessonNumber?.toString() ?? "N/A",
                          style: appStyle.fonts.B_12R.apply(
                            color: appStyle.colors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(-4, 0),
                  child: Card(
                    shadowColor: Colors.transparent,
                    color: appStyle.colors.a15p,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: ClassIconWidget(
                        color: appStyle.colors.accent,
                        size: 24,
                        uid: lesson!.uid,
                        className: lesson!.name,
                        category: lesson!.subject?.name ?? '',
                      ),
                    ),
                  ),
                ),
                Text(
                  lesson!.subject?.name ?? 'N/A',
                  style: appStyle.fonts.B_16SB.apply(
                    color: appStyle.colors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
          right: [
            Text(
              lesson!.start.format(l10n, FormatMode.hmm),
              style: appStyle.fonts.B_16R.apply(
                color: appStyle.colors.textPrimary,
              ),
            ),
            Card(
              shadowColor: Colors.transparent,
              color: appStyle.colors.a15p,
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  lesson!.roomName ?? '?',
                  style: appStyle.fonts.B_12R.apply(
                    color: appStyle.colors.secondary,
                  ),
                ),
              ),
            ),
          ],
          extra: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    timeLeftl10n(),
                    style: appStyle.fonts.B_12R.apply(
                      color: appStyle.colors.textSecondary,
                    ),
                  ),
                  Text(
                    lesson!.end.format(l10n, FormatMode.hmm),
                    style: appStyle.fonts.B_12R.apply(
                      color: appStyle.colors.textSecondary,
                    ),
                  ),
                ],
              ),
              _buildProgressBar(context, progress / duration),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCountdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FirkaCard(
          left: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Card(
                      shadowColor: Colors.transparent,
                      color: appStyle.colors.a15p,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: FirkaIconWidget(
                          FirkaIconType.majesticonsLocal,
                          'cupFilled',
                          color: appStyle.colors.accent,
                          size: 24,
                        ),
                      ),
                    ),
                    Text(
                      l10n.breakTxt,
                      style: appStyle.fonts.B_16SB.apply(
                        color: appStyle.colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
          right: [
            Text(
              timeLeftl10n(),
              style: appStyle.fonts.B_16SB.apply(
                color: appStyle.colors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBreak(BuildContext context) {
    var duration = nextLesson!.start.difference(prevLesson!.end).inMilliseconds;
    var progress = duration - nextLesson!.start.difference(now).inMilliseconds;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FirkaCard(
          left: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Card(
                      shadowColor: Colors.transparent,
                      color: appStyle.colors.a15p,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: FirkaIconWidget(
                          FirkaIconType.majesticonsLocal,
                          'cupFilled',
                          color: appStyle.colors.accent,
                          size: 24,
                        ),
                      ),
                    ),
                    Text(
                      l10n.breakTxt,
                      style: appStyle.fonts.B_16SB.apply(
                        color: appStyle.colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
          right: [
            Text(
              timeLeftl10n(),
              style: appStyle.fonts.B_16SB.apply(
                color: appStyle.colors.textPrimary,
              ),
            ),
          ],
          extra: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    prevLesson!.end.format(l10n, FormatMode.hmm),
                    style: appStyle.fonts.B_12R.apply(
                      color: appStyle.colors.textSecondary,
                    ),
                  ),
                  Text(
                    nextLesson!.start.format(l10n, FormatMode.hmm),
                    style: appStyle.fonts.B_12R.apply(
                      color: appStyle.colors.textSecondary,
                    ),
                  ),
                ],
              ),
              _buildProgressBar(context, progress / duration),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var onLesson = lesson != null;
    var hasPrevLesson = prevLesson != null;
    var hasNextLesson = nextLesson != null;

    if (onLesson) {
      return _buildOnLesson(context);
    }

    if (hasPrevLesson && !hasNextLesson) {
      return _buildAfterLessons(context);
    }

    if (!hasNextLesson && !hasPrevLesson) {
      return _buildNoLessons(context);
    }

    return _buildBreak(context);
  }
}
