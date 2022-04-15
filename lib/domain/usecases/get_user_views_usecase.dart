import 'package:jellyfin_client/domain/jellyfin/jelly_facade.dart';
import 'package:jellyfin_client/domain/jellyfin/models/jellyfin_view.dart';
import 'package:jellyfin_client/domain/storage/storage_facade.dart';

class GetUserViewUsecase {
  final JellyFacade _jellyFacade;
  final StorageFacade _storageFacade;

  const GetUserViewUsecase(this._jellyFacade, this._storageFacade);
  Future<List<JellyfinView>> execute() async {
    final bool doesUserIdExist = await _storageFacade.doesUserExist();
    if (doesUserIdExist) {
      final String uid = await _storageFacade.getUserId();
      final List<JellyfinView> views = await _jellyFacade.getUserViews(uid);
      return views;
    } else {
      throw Exception("No user currently Logged In");
    }
  }
}
