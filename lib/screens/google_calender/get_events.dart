import 'package:calendar_events/controllers/get_event_controller.dart';
import 'package:calendar_events/models/events.dart';
import 'package:calendar_events/utils/constants.dart';
import 'package:calendar_events/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetMyEvents extends StatefulWidget {
  const GetMyEvents({super.key});

  @override
  State<GetMyEvents> createState() => _GetMyEventsState();
}

class _GetMyEventsState extends State<GetMyEvents> {
  var controller = Get.put(GetEventController());
  @override
  void initState() {
    controller.getEvents();
    super.initState();
  }

  // AIzaSyBf3UZlx2LD_JNXYoQf4o88j7AY0xrOeXU
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<GetEventController>(builder: (value) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              const Text(
                'Events',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: value.event.length,
                    itemBuilder: (context, index) {
                      Events event = value.event[index];
                      return Card(
                        color: AppConstants.white,
                        child: ListTile(
                          title: Text(
                            event.name,
                            style:
                                headingText(14).copyWith(color: Colors.black),
                          ),
                          subtitle: Column(children: [
                            Row(
                              children: [
                                Text(
                                  'Start at: ',
                                  style: headingText(14)
                                      .copyWith(color: Colors.black),
                                ),
                                Text(event.start),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Ends at: ',
                                  style: headingText(14)
                                      .copyWith(color: Colors.black),
                                ),
                                Text(event.end),
                              ],
                            ),
                          ]),
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      }),
    );
  }
}
