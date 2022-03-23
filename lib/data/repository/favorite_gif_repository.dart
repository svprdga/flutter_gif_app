import 'package:flutter_gif_app/data/database/dao/favorite_gif_dao.dart';
import 'package:flutter_gif_app/data/database/database_mapper.dart';
import 'package:flutter_gif_app/domain/gif.dart';

class FavoriteGifRepository {
  final FavoriteGifDao dao;
  final DatabaseMapper mapper;

  FavoriteGifRepository({
    required this.dao,
    required this.mapper,
  });

  Future<List<Gif>> selectAll() async {
    final entities = await dao.selectAll();
    return mapper.toGifs(entities);
  }

  Future<Gif?> selectById(String id) async {
    final entity = await dao.selectById(id);
    if (entity != null) {
      return mapper.toGif(entity);
    } else {
      return null;
    }
  }

  Future<void> insert(Gif gif) async {
    final favoriteGif = mapper.toFavoriteGif(gif);
    await dao.insert(favoriteGif);
  }

  Future<void> delete(String id) async {
    await dao.delete(id);
  }
}
