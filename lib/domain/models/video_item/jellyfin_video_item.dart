
import 'package:jellyfin_client/domain/models/video_item/video_item_model.dart';

class JellyfinVideoItem extends VideoItemModel {
  final String id;
  final String backdropImageTag;
  final String serverId;
  final double playbackPercentage;

  const JellyfinVideoItem({
    required super.name,
    required super.itemType,
    super.imdbId,
    super.tmdbId,
    required this.id,
    required this.backdropImageTag,
    required this.serverId,
    required this.playbackPercentage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JellyfinVideoItem &&
        other.id == id &&
        other.backdropImageTag == backdropImageTag &&
        other.serverId == serverId &&
        other.playbackPercentage == playbackPercentage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        backdropImageTag.hashCode ^
        serverId.hashCode ^
        playbackPercentage.hashCode;
  }

  @override
  String toString() {
    return 'JellyfinVideoItem(id: $id, backdropImageTag: $backdropImageTag, serverId: $serverId, playbackPercentage: $playbackPercentage)';
  }

  factory JellyfinVideoItem.fromMap(Map<String, dynamic> map) {
    String imageTag = '';
    final jPlaybackPercentage = map["UserData"]["PlayedPercentage"].toDouble();
    final List<dynamic>? parentImagetag = map["ParentBackdropImageTags"];
    final List<dynamic>? imageBackdrop = map["BackdropImageTags"];
    if (parentImagetag != null && parentImagetag.isNotEmpty) {
      String tag = parentImagetag[0].toString();
      imageTag = tag;
    } else {
      String tag = imageBackdrop![0].toString();
      imageTag = tag;
    }
    final ItemType type =
        map['Type'] == 'Episode' ? ItemType.episode : ItemType.movie;

    final Map<String, dynamic> providerMap = map["ProviderIds"];
    final String? imdb = providerMap["Imdb"];
    final String? tmdb = providerMap["Tmdb"];
    return JellyfinVideoItem(
      name: map['Name'],
      imdbId: imdb,
      tmdbId: tmdb,
      itemType: type,
      id: map['Id'] ?? '',
      backdropImageTag: imageTag,
      serverId: map['ServerId'] ?? '',
      playbackPercentage: jPlaybackPercentage?.toDouble() ?? 0.0,
    );
  }
}