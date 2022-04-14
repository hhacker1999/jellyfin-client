import 'package:jellyfin_client/domain/jellyfin/models/jellyfin_item.dart';
import 'package:jellyfin_client/domain/jellyfin/models/jellyfin_view.dart';

abstract class JellyFacade {
  Future<List<JellyfinView>> getUserViews(String userId);
  Future<List<JellyfinItem>> getResumableItems(
      String userId, Map<String, String> header);
}
