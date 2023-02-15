import 'package:flutter/material.dart';
import 'package:flutter_application_1/draw_on_path.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:touchable/touchable.dart';

import 'body_provider.dart';
import 'file_service.dart';
import 'svg_model.dart';
import 'utils.dart';

class BodyPainter extends CustomPainter {
  final BuildContext context;
  final BodyPartsProvider bodyPartProvider;
  BodyPainter({required this.context, required this.bodyPartProvider});

  @override
  void paint(Canvas canvas, Size size) {
    TouchyCanvas ourCanvas = TouchyCanvas(context, canvas);
    var paint = Paint()..strokeWidth = 1;

    /// Scale math goes here, we scale up each path to match it's canvas size zone.
    SVG svgSize = bodyPartProvider.svgSize;
    final double xScale = size.width / svgSize.width;
    final double yScale = size.height / svgSize.height;
    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(xScale);

    bodyPartProvider.planogramsToRender.forEach((bodyPart) {
      Path path = parseSvgPathData(bodyPart.path);
      if (bodyPartProvider.selectedBodyPart == bodyPart.name) {
        bodyPart.activeColor = bodyPart.selectedColor;
      } else
        bodyPart.activeColor = bodyPart.fillColor;

      ourCanvas.drawPath(
        path.transform(matrix4.storage).shift(
              Offset(double.parse(bodyPart.x), double.parse(bodyPart.y)),
            ),
        paint
          ..color = Color(
            int.parse(bodyPart.activeColor),
          ),
        onTapDown: (details) {
          print('click ${bodyPart.name}');
          bodyPartProvider.updateSelectedBodyPart(
              newBodyPart: bodyPart.name,
              newBodyPartId: bodyPart.id.toString());
        },
      );
      // final textPainter = getTextPainterFor(
      //   bodyPart.name,
      //   TextStyle(fontSize: 5, color: Colors.black),
      //   textDirection: TextDirection.ltr,
      // );
      // textPainter.paint(
      //   canvas,

      //   Offset(double.parse(bodyPart.x), double.parse(bodyPart.y)),
      // );
      canvas.drawTextOnPath(
          bodyPart.name,
          path.transform(matrix4.storage).shift(
                Offset(double.parse(bodyPart.x), double.parse(bodyPart.y)),
              ),
          xScale,
          double.parse(bodyPart.x),
          double.parse(bodyPart.y));
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
