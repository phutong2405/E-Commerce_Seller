import 'package:flutter/material.dart';

Widget divineSpace({double? height, double? width}) {
  return SizedBox(
    height: height,
    width: width,
  );
}

Widget divineLine(
    {required List<Color> colors,
    required double space,
    double? spaceTop,
    double? spaceBot,
    double? size,
    required AlignmentGeometry start}) {
  return Column(
    children: [
      SizedBox(
        height: spaceTop ?? space,
      ),
      Container(
        height: size ?? 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors, begin: start),
        ),
      ),
      SizedBox(
        height: spaceBot ?? space,
      ),
    ],
  );
}
