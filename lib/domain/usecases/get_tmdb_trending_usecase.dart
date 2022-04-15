import 'package:jellyfin_client/domain/models/video_item/video_item_model.dart';
import 'package:jellyfin_client/domain/tmdb/tmdb_facade.dart';

class GetTmdbTrendingUsecase {
  final TmdbFacade _tmdbFacade;

  const GetTmdbTrendingUsecase(this._tmdbFacade);

  Future<List<VideoItemModel>> execute() async {
    return await _tmdbFacade.getTmdbTrendingItems();
  }
}
