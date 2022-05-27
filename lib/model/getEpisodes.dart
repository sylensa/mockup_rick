// To parse this JSON data, do
//
//     final getEpisodes = getEpisodesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GetEpisodes> getEpisodesFromJson(String str) => List<GetEpisodes>.from(json.decode(str).map((x) => GetEpisodes.fromJson(x)));

String getEpisodesToJson(List<GetEpisodes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetEpisodes {
  GetEpisodes({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  int id;
  String name;
  String airDate;
  String episode;
  List<String> characters;
  String url;
  DateTime created;

  factory GetEpisodes.fromJson(Map<String, dynamic> json) => GetEpisodes(
    id: json["id"],
    name: json["name"],
    airDate: json["air_date"],
    episode: json["episode"],
    characters: List<String>.from(json["characters"].map((x) => x)),
    url: json["url"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "air_date": airDate,
    "episode": episode,
    "characters": List<dynamic>.from(characters.map((x) => x)),
    "url": url,
    "created": created.toIso8601String(),
  };
}
