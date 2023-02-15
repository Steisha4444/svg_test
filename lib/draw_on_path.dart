library draw_on_path;

import 'package:flutter/material.dart';

import 'svg_model.dart';
import 'utils.dart';

enum TextAlignment { up, mid, bottom }

extension DrawOnPath on Canvas {
  /// draws [text] on [path] with [textStyle]
  ///
  /// It will clip [text] if it cannot fit itself in [path] for given [textStyle]
  ///
  /// [letterSpacing] is the space between 2 letters
  ///
  /// [letterSpacing] has no effect if [autoSpacing] is [true]
  ///
  /// [autoSpacing] will distribute your letters evenly
  ///
  /// Set [isClosed] to [true] if [path] is closed. This will put extra space at the end.
  /// [isClosed] has no effects if [autoSpacing] is [false]

  void drawTextOnPath(
    String text,
    Path path,
    double size,
    double x,
    double y, {
    TextStyle textStyle = const TextStyle(fontSize: 5, color: Colors.black),
    double letterSpacing = 0.0,
    bool autoSpacing = false,
    bool isClosed = false,
    TextDirection textDirection = TextDirection.ltr,
    TextAlignment textAlignment = TextAlignment.bottom,
  }) {
    if (text.isEmpty) {
      return;
    }

    final pathMetrics = path.computeMetrics();
    // print("pathMetrics");
    // print(pathMetrics);
    final pathMetricsList = pathMetrics.toList();
    // print("pathMetricsList");
    // pathMetricsList.forEach((element) {
    //   print(element.toString());
    // });

    if (autoSpacing && text.length > 1) {
      var totalLength = 0.0;

      for (var metric in path.computeMetrics()) {
        totalLength += metric.length;
      }

      final textSize = getTextPainterFor(
        text,
        textStyle,
        textDirection: textDirection,
      ).size;

      final chars = isClosed ? (text.length) : (text.length - 1);

      letterSpacing = (totalLength - textSize.width) / chars;
    }

    int currentMetric = 0;
    double currDist = 0;

    for (int i = 0; i < text.length; i++) {
      final textPainter = getTextPainterFor(
        text[i],
        textStyle,
        textDirection: textDirection,
      );
      final charSize = textPainter.size;

      final tangent = pathMetricsList[currentMetric]
          .getTangentForOffset(currDist + charSize.width / 2)!;
      final currLetterPos = tangent.position;
      final currLetterAngle = tangent.angle;
      var bodyPartProvider;

      save();
      translate(currLetterPos.dx, currLetterPos.dy);
      rotate(-currLetterAngle);
      scale(size);

      textPainter.paint(
        this,
        currLetterPos
            .translate(
              -currLetterPos.dx,
              -currLetterPos.dy,
            )
            .translate(
              -charSize.width * 0.5,
              -charSize.height *
                  getTranslateYFactorForTextAlignment(textAlignment),
            ),
      );

      restore();
      currDist += charSize.width + letterSpacing;

      if (currDist > pathMetricsList[currentMetric].length) {
        currDist = 0;
        currentMetric++;
      }

      if (currentMetric == pathMetricsList.length) {
        break;
      }
    }
  }

  /// draws pattern defined in [drawElementAt] along [path].
  ///
  /// [index] can be used to draw different element at different position based on some logic.
  ///
  /// Use [canvas] to draw anything at [position].
  /// The next [position] is calculated based on [spacing] provided.

  /// [spacing] should be greater than [0].
  /// Ideally [spacing] [=] element width [+] spacing between two elements
  /// (spacing between starting points of two consecutive elements)

}
