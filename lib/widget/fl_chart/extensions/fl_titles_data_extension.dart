import 'package:flutter/widgets.dart';
import 'package:newmaster/widget/fl_chart/extensions/side_titles_extension.dart';

import '../chart/base/axis_chart/axis_chart_data.dart';

extension FlTitlesDataExtension on FlTitlesData {
  EdgeInsets get allSidesPadding {
    return EdgeInsets.only(
      left: show ? leftTitles.totalReservedSize : 0.0,
      top: show ? topTitles.totalReservedSize : 0.0,
      right: show ? rightTitles.totalReservedSize : 0.0,
      bottom: show ? bottomTitles.totalReservedSize : 0.0,
    );
  }
}
