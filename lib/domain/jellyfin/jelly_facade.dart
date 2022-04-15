import 'package:jellyfin_client/domain/models/jellyfin_view.dart';
import 'package:jellyfin_client/domain/models/video_item/video_item_model.dart';

abstract class JellyFacade {
  Future<List<JellyfinView>> getUserViews(String userId);
  Future<List<VideoItemModel>> getResumableItems(
      String userId, Map<String, String> header);
}
