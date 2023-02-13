import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'body_chart.dart';
import 'strings.dart';

class OurDrawerMenu extends StatelessWidget {
  const OurDrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListTile(
        title: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => BodyChart(),
              ),
            );
          },
          child: Text('${MenuNames.kBodyChart}'),
        ),
      ),
    );
  }
}
