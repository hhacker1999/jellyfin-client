import 'package:jellyfin_client/domain/jellyfin/jellyfin_view.dart';

abstract class JellyFacade {
  Future<List<JellyfinView>> getUserViews(String userId);
}
