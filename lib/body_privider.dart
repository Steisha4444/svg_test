import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/svg_component.dart';
import 'package:flutter_application_1/svg_planogram.dart';

class BodyPartsProvider with ChangeNotifier {
  String selectedBodyPart = 'none';
  String selectedBodyPartId = '';
  List<SvgComponent> parts = [];

  /// Switch render side
  get bodyPartsToRender {
    return parts;
  }

  void loadBodyPartsList({required List<SvgComponent> bodyParts}) {
    parts = bodyParts;
  }

  void updateSelectedBodyPart(
      {required String newBodyPart, required String newBodyPartId}) {
    selectedBodyPart = newBodyPart;
    selectedBodyPartId = newBodyPartId;
    notifyListeners();
  }
}
