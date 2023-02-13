import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/body_privider.dart';
import 'package:flutter_application_1/file_service.dart';
import 'package:provider/provider.dart';

import 'assets_path.dart';
import 'our_drawer_menu.dart';
import 'strings.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FilesProcessServices loader = FilesProcessServices();
    BodyPartsProvider _bodyPartsProvider =
        Provider.of<BodyPartsProvider>(context, listen: false);

    loader.loadBodyParts(
        path: UnifiedPracticeAssetsPath.kBodyMapFrontSvg,
        bodyPartsProvider: _bodyPartsProvider);

    return Scaffold(
      drawer: OurDrawerMenu(),
      appBar: AppBar(
        title: Text(MenuNames.kHomeScreenTitle),
      ),
      body: Container(),
    );
  }
}
