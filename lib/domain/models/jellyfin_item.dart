import 'dart:convert';

class JellyfinItem {
  String id;
  String serverId;
  String name;
  double playbackPercentage;
  String backdropImageTag;
  JellyfinItem({
    required this.id,
    required this.serverId,
    required this.name,
    required this.playbackPercentage,
    required this.backdropImageTag,
  });

  JellyfinItem copyWith({
    String? id,
    String? serverId,
    String? name,
    double? playbackPercentage,
    String? backdropImageTag,
  }) {
    return JellyfinItem(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      name: name ?? this.name,
      playbackPercentage: playbackPercentage ?? this.playbackPercentage,
      backdropImageTag: backdropImageTag ?? this.backdropImageTag,
    );
  }

  factory JellyfinItem.fromMap(Map<String, dynamic> map) {
    String imageTag = '';
    final playbackPercentage = map["UserData"]["PlayedPercentage"].toDouble();
    final List<dynamic>? parentImagetag = map["ParentBackdropImageTags"];
    final List<dynamic>? imageBackdrop = map["BackdropImageTags"];
    if (parentImagetag != null && parentImagetag.isNotEmpty) {
      String tag = parentImagetag[0].toString();
      imageTag = tag;
    } else {
      String tag = imageBackdrop![0].toString();
      imageTag = tag;
    }
    return JellyfinItem(
      id: map['Id'] ?? '',
      serverId: map['ServerId'] ?? '',
      name: map['Name'] ?? '',
      playbackPercentage: playbackPercentage ?? 0.0,
      backdropImageTag: imageTag,
    );
  }

  factory JellyfinItem.fromJson(String source) =>
      JellyfinItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'JellyfinItem(id: $id, serverId: $serverId, name: $name, playbackPercentage: $playbackPercentage, backdropImageTag: $backdropImageTag)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JellyfinItem &&
        other.id == id &&
        other.serverId == serverId &&
        other.name == name &&
        other.playbackPercentage == playbackPercentage &&
        other.backdropImageTag == backdropImageTag;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        serverId.hashCode ^
        name.hashCode ^
        playbackPercentage.hashCode ^
        backdropImageTag.hashCode;
  }
}
