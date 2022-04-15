enum ItemType { movie, episode }

abstract class VideoItemModel {
  final String name;
  final String? imdbId;
  final String? tmdbId;
  final ItemType itemType;
  const VideoItemModel({
    required this.name,
    this.imdbId,
    this.tmdbId,
    required this.itemType,
  });

  @override
  String toString() {
    return 'VideoItemModel(name: $name, imdbId: $imdbId, tmdbId: $tmdbId, itemType: $itemType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VideoItemModel &&
        other.name == name &&
        other.imdbId == imdbId &&
        other.tmdbId == tmdbId &&
        other.itemType == itemType;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        imdbId.hashCode ^
        tmdbId.hashCode ^
        itemType.hashCode;
  }
}
