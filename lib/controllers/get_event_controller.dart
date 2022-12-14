import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_manager.dart';
import '../models/events.dart';

class GetEventController extends GetxController {
  List<Events> event = [];

  Future<void> getEvents() async {
    event.clear();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var email = sharedPreferences.getString('email') ?? '';
    var pin = sharedPreferences.getInt('pin') ?? 0;
    String res = await ApiManager.fetchPost(
        'events/getEvents',
        jsonEncode({
          'email': email,
          'pin': pin,
        }));
    if (res.contains('success')) {
      List eventsMap = jsonDecode(res)['results']['events'] as List;

      for (var element in eventsMap) {
        event.add(Events.fromMap(element));
      }

      update();
    }
  }
}
