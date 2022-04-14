import 'package:dio/dio.dart';
import 'package:jellyfin_client/app/constansts.dart';
import 'package:jellyfin_client/domain/jellyfin/jelly_facade.dart';
import 'package:jellyfin_client/domain/jellyfin/models/jellyfin_item.dart';
import 'package:jellyfin_client/domain/jellyfin/models/jellyfin_view.dart';

class JellyfinImplementation implements JellyFacade {
  final Dio _client;

  const JellyfinImplementation(this._client);
  @override
  Future<List<JellyfinView>> getUserViews(String userId) async {
    try {
      final String viewPath = AppConstants.getViewUrl(userId);
      final dioRes = await _client.get("http://192.168.0.161:8096$viewPath");
      final Map<String, dynamic> resMap = dioRes.data;
      final List<dynamic> viewMap = resMap["Items"];
      final List<JellyfinView> views =
          viewMap.map((e) => JellyfinView.fromMap(e)).toList();
      return views;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<JellyfinItem>> getResumableItems(
      String userId, Map<String, String> header) async {
    try {
      final resumePath = AppConstants.getResumeItemUrl(userId);
      final dioRes = await _client.get(
        "http://192.168.0.161:8096$resumePath",
        queryParameters: {
          "Limit": 12,
          "Recursive": true,
          "MediaTypes": "Video",
          "ImageTypeLimit": 1,
          "EnableImageTypes": "Backdrop, Primary, Thumb"
        },
        options: Options(headers: header),
      );
      List<dynamic> resMapList = dioRes.data["Items"];
      return resMapList.map((e) => JellyfinItem.fromMap(e)).toList();
    } catch (_) {
      rethrow;
    }
  }
}
