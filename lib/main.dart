import 'package:flutter/material.dart';
import 'package:moviesdb/views/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates:
          AppLocalizations.localizationsDelegates, // important
      supportedLocales: AppLocalizations.supportedLocales, // important
      home: HomePage(),
    );
  }
}
