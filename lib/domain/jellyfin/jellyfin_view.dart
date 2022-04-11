import 'dart:convert';

class JellyfinView {
  String name;
  String id;
  String serverId;
  String collectionType;
  JellyfinView({
    required this.name,
    required this.id,
    required this.serverId,
    required this.collectionType,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'Name': name});
    result.addAll({'Id': id});
    result.addAll({'ServerId': serverId});
    result.addAll({'CollectionType': collectionType});

    return result;
  }

  factory JellyfinView.fromMap(Map<String, dynamic> map) {
    return JellyfinView(
      name: map['Name'] ?? '',
      id: map['Id'] ?? '',
      serverId: map['ServerId'] ?? '',
      collectionType: map['CollectionType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory JellyfinView.fromJson(String source) =>
      JellyfinView.fromMap(json.decode(source));

  @override
  String toString() {
    return 'JellyfinView(name: $name, id: $id, serverId: $serverId, collectionType: $collectionType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JellyfinView &&
        other.name == name &&
        other.id == id &&
        other.serverId == serverId &&
        other.collectionType == collectionType;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        serverId.hashCode ^
        collectionType.hashCode;
  }
}
