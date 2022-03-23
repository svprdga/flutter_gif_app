import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif_app/data/database/dao/favorite_gif_dao.dart';
import 'package:flutter_gif_app/data/database/database_mapper.dart';
import 'package:flutter_gif_app/data/network/client/giphy_client.dart';
import 'package:flutter_gif_app/data/network/network_mapper.dart';
import 'package:flutter_gif_app/data/repository/favorite_gif_repository.dart';
import 'package:flutter_gif_app/data/repository/giphy_repository.dart';
import 'package:flutter_gif_app/keys.dart';
import 'package:flutter_gif_app/presentation/app/app.dart';
import 'package:flutter_gif_app/presentation/app/app_model.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final providers = createProviders();

  // ignore: deprecated_member_use, avoid_redundant_argument_values
  Sqflite.devSetDebugModeOn(kDebugMode);

  runApp(
    App(
      providers: providers,
    ),
  );
}

List<SingleChildWidget> createProviders() {
  // Util
  final log = Logger(printer: PrettyPrinter());

  // Data
  final networkMapper = NetworkMapper();

  final giphyRepo = GiphyRepository(
    client: GiphyClient(
      baseUrl: 'https://api.giphy.com/',
      apiKey: giphyApiKey,
      log: log,
    ),
    mapper: networkMapper,
  );

  final favoriteGifDao = FavoriteGifDao();
  final databaseMapper = DatabaseMapper();
  final favoriteGifRepository = FavoriteGifRepository(
    dao: favoriteGifDao,
    mapper: databaseMapper,
  );

  // Create list of providers
  return [
    Provider<Logger>.value(value: log),
    Provider<GiphyRepository>.value(value: giphyRepo),
    Provider<FavoriteGifRepository>.value(value: favoriteGifRepository),
    ChangeNotifierProvider<AppModel>(
      create: (context) => AppModel(),
    ),
  ];
}
