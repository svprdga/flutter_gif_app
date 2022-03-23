import 'package:flutter/material.dart';
import 'package:flutter_gif_app/data/repository/favorite_gif_repository.dart';
import 'package:flutter_gif_app/domain/gif.dart';

class DetailModel extends ChangeNotifier {
  final FavoriteGifRepository _favoriteGifRepo;
  final Gif _gif;

  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  set isFavorite(bool value) {
    if (value != _isFavorite) {
      _isFavorite = value;
      notifyListeners();
    }
  }

  DetailModel(
    this._favoriteGifRepo,
    this._gif,
  );

  Future<void> checkFavorite() async {
    isFavorite = await _favoriteGifRepo.selectById(_gif.id) != null;
  }

  Future<void> addToFavorites() async {
    await _favoriteGifRepo.insert(_gif);
    isFavorite = true;
  }

  Future<void> removeFromFavorites() async {
    await _favoriteGifRepo.delete(_gif.id);
    isFavorite = false;
  }
}
