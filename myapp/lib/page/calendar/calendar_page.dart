import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/db/services/list_instance_service.dart';
import 'package:myapp/model/list_instance.dart';
import './day_detail_page.dart';
import './../../widget/calendar/calendar_card_widget.dart';
import './../../widget/common/side_nav.dart';
// import '../../db/Calendar/Calendars_database.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CalendarsPage extends StatefulWidget {
  @override
  _CalendarsPageState createState() => _CalendarsPageState();
}

class Day {
  late DateTime date;
  List<ListInstance> instances = [];
}

class _CalendarsPageState extends State<CalendarsPage> {
  List<Day> days = [];
  late List<ListInstance> listInstances;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshCalendars();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future refreshCalendars() async {
    setState(() => isLoading = true);
    listInstances =
        await ListInstancesService.instance.readAllAssignedListInstances();

    final today = DateTime.now();
    final firstDayOfWeek = today.subtract(Duration(days: today.weekday - 1));
    var dates =
        List.generate(7, (index) => firstDayOfWeek.add(Duration(days: index)));

    days = dates.map((date) {
      final day = Day();
      day.date = date;
      day.instances = listInstances
          .where((instance) => isRepeatedToday(instance, date))
          .toList(growable: false);
      return day;
    }).toList(growable: false);
    days.forEach((element) {});
    setState(() => isLoading = false);
  }

  bool isRepeatedToday(ListInstance instance, DateTime date) {
    bool isRepeatedOn = instance.repeatOn != null
        ? instance.repeatOn!.contains(date.weekday.toString())
        : false;

    bool isRepeatedEvery = instance.repeatEvery != null
        ? daysBetween(date, DateTime.now()) % instance.repeatEvery! == 0
        : false;

    return isRepeatedOn || isRepeatedEvery;
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Calendars',
            style: TextStyle(fontSize: 24),
          ),
          actions: const [Icon(Icons.search), SizedBox(width: 12)],
        ),
        drawer: NavDrawer(),
        body: Center(
          child: buildCalendars(),
        ),
      );

  Widget buildCalendars() => MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    DayDetailPage(day: day.date, listInstances: day.instances),
              ));

              refreshCalendars();
            },
            child: CalendarCardWidget(
                day: day.date, listInstances: day.instances, index: index),
          );
        },
      );
}
