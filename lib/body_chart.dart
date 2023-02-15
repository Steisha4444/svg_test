import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/strings.dart';
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';

import 'body_canvas.dart';

import 'body_provider.dart';

class BodyChart extends StatefulWidget {
  @override
  _BodyChartState createState() => _BodyChartState();
}

class _BodyChartState extends State<BodyChart> {
  bool isInteracting = false;
  FocusNode _canvasNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_canvasNode);
    BodyPartsProvider bodyPartsProvider =
        Provider.of<BodyPartsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          MenuNames.kBodyChart,
        ),
      ),
      body: InteractiveViewer(
        maxScale: 5,
        minScale: 1,
        // onInteractionStart: (scaleStartDetails) => isInteracting = true,
        // onInteractionEnd: (scaleEndDetails) => isInteracting = false,
        // constrained: true,
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.65,
          width: MediaQuery.of(context).size.width,
          child: CanvasTouchDetector(
            gesturesToOverride: [GestureType.onTapDown, GestureType.onTapUp],
            builder: (context) => CustomPaint(
              painter: BodyPainter(
                  context: context, bodyPartProvider: bodyPartsProvider),
            ),
          ),
        ),
      ),
    );
  }
}
