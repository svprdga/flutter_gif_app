import 'package:flutter/material.dart';
import 'package:flutter_gif_app/presentation/app/app_model.dart';
import 'package:flutter_gif_app/presentation/main/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class App extends StatelessWidget {
  final List<SingleChildWidget> providers;

  const App({required this.providers});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<AppModel>(
        builder: (BuildContext context, AppModel model, Widget? child) {
          return MaterialApp(
            title: 'GIFs!',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: Brightness.light,
              iconTheme: const IconThemeData(
                color: Colors.black54,
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: Brightness.dark,
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
              ),
            ),
            themeMode: model.themeMode,
            home: MainScreen(),
          );
        },
      ),
    );
  }
}
