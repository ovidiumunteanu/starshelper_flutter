import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

import 'package:flutter_timetable_view/flutter_timetable_view.dart';

class CourseplanPage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    double lanewidth = 80.0;
    return Scaffold(
      appBar: AppBar(),
      body: TimetableView(
        timetableStyle: const TimetableStyle(
          startHour: 9,
          endHour: 19,
          timeItemWidth: 80,
          laneWidth: 80.0,
        ),
        laneEventsList: [
          LaneEvents(
              lane: Lane(
                width: lanewidth,
                name: 'Monday',
              ),
              events: [
                TableEvent(
                  title: 'An event 1',
                  start: TableEventTime(hour: 10, minute: 0),
                  end: TableEventTime(hour: 11, minute: 20),
                ),
              ]),
          LaneEvents(
              lane: Lane(
                width: lanewidth,
                name: 'Tuesday',
              ),
              events: [
                TableEvent(
                  title: 'An event 1',
                  start: TableEventTime(hour: 10, minute: 0),
                  end: TableEventTime(hour: 11, minute: 20),
                ),
              ]),
          LaneEvents(
              lane: Lane(
                width: lanewidth,
                name: 'Wednesday',
              ),
              events: [
                TableEvent(
                  title: 'An event 1',
                  start: TableEventTime(hour: 10, minute: 0),
                  end: TableEventTime(hour: 11, minute: 20),
                ),
              ]),
          LaneEvents(
              lane: Lane(
                width: lanewidth,
                name: 'Thursday',
              ),
              events: [
                TableEvent(
                  title: 'An event 1',
                  start: TableEventTime(hour: 10, minute: 0),
                  end: TableEventTime(hour: 11, minute: 20),
                ),
              ]),
          LaneEvents(
              lane: Lane(
                width: lanewidth,
                name: 'Friday',
              ),
              events: [
                TableEvent(
                  title: 'An event 1',
                  start: TableEventTime(hour: 10, minute: 0),
                  end: TableEventTime(hour: 11, minute: 20),
                ),
              ]),
        ],
      ),
    );
  }
}
