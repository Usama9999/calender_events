// To parse this JSON data, do
//
//     final events = eventsFromMap(jsonString);

import 'dart:convert';

class Events {
  Events({
    required this.name,
    required this.start,
    required this.end,
  });

  String name;
  String start;
  String end;

  factory Events.fromJson(String str) => Events.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Events.fromMap(Map<String, dynamic> json) => Events(
        name: json["name"],
        start: json["start"],
        end: json["end"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "start": start,
        "end": end,
      };
}
