import 'dart:convert';

import 'package:webtoon_api_app/models/webtoon_episode_model.dart';
import 'package:webtoon_api_app/models/webtoon_model.dart';
import 'package:http/http.dart' as http;

import '../models/webtoon_detail_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = 'today';

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final uri = Uri.parse('$baseUrl/$today');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final uri = Uri.parse('$baseUrl/$id');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }


  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById
      (String id) async {
    final uri = Uri.parse('$baseUrl/$id/episodes');
    List<WebtoonEpisodeModel> episodeInstances = [];
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        final instance = WebtoonEpisodeModel.fromJson(episode);
        episodeInstances.add(instance);
      }
      return episodeInstances;
    }
    throw Error();
  }
}