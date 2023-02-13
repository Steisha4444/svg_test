import 'package:flutter/services.dart';
import 'package:flutter_application_1/svg_component.dart';
import 'package:xml/xml.dart';

import 'body_privider.dart';

class FilesProcessServices {
  /// 1. Extract all paths from SVG Images => <path>
  Future<Iterable<XmlElement>> extractPathsFromSvg(
      {required String svgImage}) async {
    String generalString = await rootBundle.loadString(svgImage);
    XmlDocument document = XmlDocument.parse(generalString);
    final paths = document.findAllElements('path');
    return paths;
  }

  /// 2. Map all attributes from extracted paths to BodyPart Objects  => List<BodyPart>
  Future<List<SvgComponent>> mapSvgImage({required String svgImage}) async {
    List<SvgComponent> retBodyPartList = [];
    Iterable<XmlElement> paths = await extractPathsFromSvg(svgImage: svgImage);
    int count = 0;
    paths.forEach((path) {
      String partName = path.getAttribute('id').toString();
      String partPath = path.getAttribute('d').toString();
      String fillColor =
          path.getAttribute('fill').toString().replaceFirst('#', '0xFF');

      if (!partName.contains('path')) {
        SvgComponent part = SvgComponent(
            name: partName,
            path: partPath,
            fillColor: fillColor,
            id: count,
            isSelected: false);
        retBodyPartList.add(part);
        count++;
      }
    });
    count = 0;
    return retBodyPartList;
  }

  /// 3. Load parts

  void loadBodyParts({
    required String path,
    required BodyPartsProvider bodyPartsProvider,
  }) {
    FilesProcessServices _bodyChartServices = FilesProcessServices();
    _bodyChartServices.mapSvgImage(svgImage: path).then((value) {
      bodyPartsProvider.loadBodyPartsList(bodyParts: value);
    });
  }
}
