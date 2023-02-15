import 'package:flutter/services.dart';
import 'package:flutter_application_1/svg_component.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart';

import 'body_provider.dart';
import 'svg_model.dart';

class FilesProcessServices {
  SVG? svg;

  /// 1. Extract all paths from SVG Images => <path>
  ///
  ///
  Future<Iterable<XmlElement>> extractPathsFromSvg(
      {required String svgImage}) async {
    String generalString = await rootBundle.loadString(svgImage);
    XmlDocument document = XmlDocument.parse(generalString);
    final paths = document.findAllElements('path');
    return paths;
  }

  Future<SVG> extractSvgSize({required String svgImage}) async {
    String generalString = await rootBundle.loadString(svgImage);
    XmlDocument document = XmlDocument.parse(generalString);
    final paths = document.findAllElements('svg');

    double svgWidth =
        double.parse(paths.first.getAttribute('width').toString());
    double svgHeight =
        double.parse(paths.first.getAttribute('height').toString());

    return SVG(svgHeight, svgWidth);
  }

  /// 2. Map all attributes from extracted paths to BodyPart Objects  => List<BodyPart>
  Future<List<SvgComponent>> mapSvgImage({required String svgImage}) async {
    List<SvgComponent> retBodyPartList = [];
    Iterable<XmlElement> paths = await extractPathsFromSvg(svgImage: svgImage);

    int count = 0;
    paths.forEach((path) {
      String partName = path.getAttribute('class').toString();
      String partPath = path.getAttribute('d').toString();
      String x = path.getAttribute('x').toString();
      String y = path.getAttribute('y').toString();
      String transform = path.getAttribute('transform').toString();
      String fillColor =
          path.getAttribute('fill').toString().replaceFirst('#', '0xFF');

      if (!partName.contains('path')) {
        SvgComponent part = SvgComponent(
            name: partName,
            path: partPath,
            fillColor: fillColor == 'null' ? "0xFFe0e0e0" : fillColor,
            id: count,
            x: x == 'null' ? "0.0" : x,
            y: y == 'null' ? "0.0" : y,
            transform: transform,
            isSelected: false);
        retBodyPartList.add(part);
        count++;
      }
    });
    count = 0;
    return retBodyPartList;
  }

  /// 3. Load parts

  Future<void> loadBodyParts({
    required String path,
    required BodyPartsProvider bodyPartsProvider,
  }) async {
    FilesProcessServices _bodyChartServices = FilesProcessServices();
    List<SvgComponent> planograms =
        await _bodyChartServices.mapSvgImage(svgImage: path);

    svg = await extractSvgSize(svgImage: path);
    bodyPartsProvider.loadPlanogramList(bodyParts: planograms, size: svg!);
  }
}
