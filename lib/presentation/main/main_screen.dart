import 'package:flutter/material.dart';
import 'package:flutter_gif_app/presentation/app/app_model.dart';
import 'package:flutter_gif_app/presentation/favorites/favorites.dart';
import 'package:flutter_gif_app/presentation/gifs/gifs_list.dart';
import 'package:flutter_gif_app/presentation/main/main_model.dart';
import 'package:flutter_gif_app/util/design_utils.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget with DesignUtils {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (context) => MainModel(),
      child: Consumer<MainModel>(
        builder: (context, bloc, child) {
          Widget tab;
          switch (bloc.mainTab) {
            case MainTab.gifs:
              tab = const GifsList();
              break;
            case MainTab.favorites:
              tab = const Favorites();
              break;
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Flutter GIFs sample'),
              actions: [
                IconButton(
                  onPressed: () {
                    final appModel =
                        Provider.of<AppModel>(context, listen: false);

                    if (isLight(context)) {
                      appModel.themeMode = ThemeMode.dark;
                    } else {
                      appModel.themeMode = ThemeMode.light;
                    }
                  },
                  icon: Icon(
                    isLight(context) ? Icons.dark_mode : Icons.light_mode,
                  ),
                ),
              ],
            ),
            body: tab,
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.gif),
                  label: 'GIFs',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                )
              ],
              currentIndex: bloc.mainTab.index,
              onTap: (int index) => bloc.mainTab = MainTab.values[index],
            ),
          );
        },
      ),
    );
  }
}
