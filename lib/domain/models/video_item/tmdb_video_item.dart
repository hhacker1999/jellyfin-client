import 'package:jellyfin_client/domain/models/video_item/video_item_model.dart';

class TmdbVideoItem extends VideoItemModel {
  final String posterTag;
  final bool isAvailable;

  const TmdbVideoItem(
      {required super.name,
      required super.itemType,
      required this.isAvailable,
      required this.posterTag,
      super.imdbId,
      super.tmdbId});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TmdbVideoItem &&
        other.posterTag == posterTag &&
        other.isAvailable == isAvailable;
  }

  @override
  int get hashCode => posterTag.hashCode ^ isAvailable.hashCode;

  @override
  String toString() =>
      'TmdbVideoItem(posterTag: $posterTag, isAvailable: $isAvailable)';

  factory TmdbVideoItem.fromMap(Map<String, dynamic> map) {
    final ItemType itemType =
        map['media_type'] == 'movie' ? ItemType.movie : ItemType.episode;
    return TmdbVideoItem(
      name: itemType == ItemType.movie ? map['title'] : map['name'],
      tmdbId: map['id'].toString(),
      itemType: itemType,
      posterTag: map['poster_path'],
      isAvailable: map['isAvailable'] ?? false,
    );
  }
}
