import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'body_provider.dart';
import 'colors.dart';
import 'my_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<BodyPartsProvider>(
          create: (_) => BodyPartsProvider(),
        ),
      ],
      child: MaterialApp(
        home: MyApp(),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            actionsIconTheme: IconThemeData(color: Colors.white),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                UnifiedPracticeColors.kUnifiedPracticePrimaryColor,
              ),
            ),
          ),
          primaryColor: UnifiedPracticeColors.kUnifiedPracticePrimaryColor,
          primaryTextTheme: TextTheme(
            headline6: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}
