import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/svg_component.dart';
import 'package:flutter_application_1/svg_planogram.dart';

import 'svg_model.dart';

class BodyPartsProvider with ChangeNotifier {
  String selectedBodyPart = 'none';
  String selectedBodyPartId = '';
  List<SvgComponent> parts = [];
  SVG? svg;

  /// Switch render side
  get planogramsToRender {
    return parts;
  }

  get svgSize {
    return svg;
  }

  void loadPlanogramList(
      {required List<SvgComponent> bodyParts, required SVG size}) {
    parts = bodyParts;
    svg = size;
  }

  void updateSelectedBodyPart(
      {required String newBodyPart, required String newBodyPartId}) {
    selectedBodyPart = newBodyPart;
    selectedBodyPartId = newBodyPartId;
    notifyListeners();
  }
}
