import 'package:jellyfin_client/domain/models/video_item/video_item_model.dart';

abstract class TmdbFacade{
Future<List<VideoItemModel>> getTmdbTrendingItems();
}