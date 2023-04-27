import 'dart:developer';

import 'package:get/get.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as gapis;
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;
import 'package:http/http.dart' as http;

class GetEventController extends GetxController {
  late Events events;
  List<Event> event = [];

  Future<void> getEvents() async {
    log('message');
    try {
      final auth.AuthClient? client = await authenticatedClient();
      var calendar = CalendarApi(client!);
      String calendarId = "primary";
      calendar.events.list(calendarId).then((value) async {
        events = value;
        event = value.items!;
        log('Number of events${event.length}');

        event.removeAt(0);
        event = event.reversed.toList();
        update();
      });
    } catch (e) {
      log('Error creating event $e');
    }
  }

  Future<gapis.AuthClient?> authenticatedClient() async {
    const String oathTokenString =
        "ya29.a0Ael9sCNBCFKzsae92NUF2B1aWZgrdnuaZjEhZ7bTYHLz7rbTzJNt27MMN87gfu_atWLlfV8mLEUvMmVwzlIVgXoQ2iu-xIIIDrF3rOgDV9zOCX4M1men21rYlK0Kh01PswO0Y-g1L-xH80biQprDcwvTmbWraCgYKAV8SARISFQF4udJhXK4RLmpk-_j1KlrcLZVDoQ0163";

    final gapis.AccessCredentials credentials = gapis.AccessCredentials(
      gapis.AccessToken(
        'Bearer',
        oathTokenString,
        DateTime.now().toUtc().add(const Duration(days: 365)),
      ),
      null, // We don't have a refreshToken
      [],
    );

    return gapis.authenticatedClient(http.Client(), credentials);
  }
}
