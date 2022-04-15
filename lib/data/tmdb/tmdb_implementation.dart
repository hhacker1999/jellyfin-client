import 'package:dio/dio.dart';
import 'package:jellyfin_client/app/constansts.dart';
import 'package:jellyfin_client/domain/models/video_item/tmdb_video_item.dart';
import 'package:jellyfin_client/domain/models/video_item/video_item_model.dart';
import 'package:jellyfin_client/domain/tmdb/tmdb_facade.dart';

class TmdbImplementation implements TmdbFacade {
  final Dio _client;

  const TmdbImplementation(this._client);
  @override
  Future<List<VideoItemModel>> getTmdbTrendingItems() async {
    try {
      final dioRes =
          await _client.get(AppConstants.tmdbTrendingUrl, queryParameters: {
        'api_key': AppConstants.tmdbApi,
      });
      final List<dynamic> mapList = dioRes.data["results"];
      final List<TmdbVideoItem> items =
          mapList.map((e) => TmdbVideoItem.fromMap(e)).toList();
      return items;
    } catch (_) {
      rethrow;
    }
  }
}
