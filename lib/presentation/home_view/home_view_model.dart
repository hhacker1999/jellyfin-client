import 'package:rxdart/rxdart.dart';

import 'package:jellyfin_client/domain/models/video_item/video_item_model.dart';
import 'package:jellyfin_client/domain/usecases/get_resumable_items_usecase.dart';
import 'package:jellyfin_client/domain/usecases/get_tmdb_trending_usecase.dart';

class HomeViewModel {
  final GetResumableItemsUsecase getResumableItemsUsecase;
  final GetTmdbTrendingUsecase getTmdbTrendingUsecase;
  final BehaviorSubject<HomeViewState> _stateSubject =
      BehaviorSubject.seeded(HomeViewInitial());
  HomeViewModel(
      {required this.getResumableItemsUsecase,
      required this.getTmdbTrendingUsecase}) {
    _loadItems();
  }

  ValueStream<HomeViewState> get state => _stateSubject;

  Future<void> _loadItems() async {
    _stateSubject.add(HomeViewLoading());
    try {
      final List<VideoItemModel> tmdbList =
          await getTmdbTrendingUsecase.execute();
      final List<VideoItemModel> resumeList =
          await getResumableItemsUsecase.execute();

      _stateSubject
          .add(HomeViewLoaded(tmdbList: tmdbList, resumableList: resumeList));
    } catch (e) {
      _stateSubject.add(
        HomeViewError(
          error: e.toString(),
        ),
      );
    }
  }

  void dispose() {
    _stateSubject.close();
  }
}

abstract class HomeViewState {}

class HomeViewInitial implements HomeViewState {}

class HomeViewLoading implements HomeViewState {}

class HomeViewError implements HomeViewState {
  final String error;
  const HomeViewError({
    required this.error,
  });
}

class HomeViewLoaded implements HomeViewState {
  final List<VideoItemModel> tmdbList;
  final List<VideoItemModel> resumableList;
  const HomeViewLoaded({
    required this.tmdbList,
    required this.resumableList,
  });
}
