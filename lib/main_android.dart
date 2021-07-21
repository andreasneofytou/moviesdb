import 'package:flutter/material.dart';
import 'package:moviesdb/views/android/discover_page.dart';
import 'package:moviesdb/views/android/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainAndroid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates:
            AppLocalizations.localizationsDelegates, // important
        supportedLocales: AppLocalizations.supportedLocales, // important
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<Widget> _tabs = [HomePage(), DiscoverPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: AppLocalizations.of(context)!.homeTabText),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: AppLocalizations.of(context)!.discoverTabText),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[300],
        onTap: _onItemTapped,
      ),
      body: IndexedStack(index: _selectedIndex, children: _tabs),
    );
  }
}
