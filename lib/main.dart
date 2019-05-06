import 'package:flutter/material.dart';
import 'package:gifs_search/ui/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class GifsSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      color: Colors.black,
      title: "Gifs Search",
      theme: ThemeData(
        hintColor: Colors.white,
      ),
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      localeResolutionCallback: (l, s) => l,
    );
  }
}

void main() => runApp(GifsSearch());
