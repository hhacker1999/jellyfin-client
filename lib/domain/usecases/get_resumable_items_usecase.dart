import 'package:jellyfin_client/domain/jellyfin/jelly_facade.dart';
import 'package:jellyfin_client/domain/models/jellyfin_item.dart';
import 'package:jellyfin_client/domain/storage/storage_facade.dart';
import 'package:jellyfin_client/domain/usecases/create_header_usecase.dart';


class GetResumableItemsUsecase {
  final CreateHeaderUsecase _createHeaderUsecase;
  final JellyFacade _jellyFacade;
  final StorageFacade _storageFacade;

  const GetResumableItemsUsecase(
      this._createHeaderUsecase, this._jellyFacade, this._storageFacade);

  Future<List<JellyfinItem>> execute() async {
    final uid = await _storageFacade.getUserId();
    final header = await _createHeaderUsecase.execute();
    final items = await _jellyFacade.getResumableItems(uid, header);
    return items;
  }
}
