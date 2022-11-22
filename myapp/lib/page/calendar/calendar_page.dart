import 'package:flutter/material.dart';
import 'package:myapp/page/calendar/day_detail_page.dart';
import 'package:myapp/page/widget/calendar/calendar_card_widget.dart';
import 'package:myapp/page/widget/common/side_nav.dart';
// import '../../db/Calendar/Calendars_database.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CalendarsPage extends StatefulWidget {
  @override
  _CalendarsPageState createState() => _CalendarsPageState();
}

class _CalendarsPageState extends State<CalendarsPage> {
  late List<DateTime> days;
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

    // Calendars = await CalendarsDatabase.instance.readAllCalendars() as List<Calendar>;
    //final today id todays date
    final today = DateTime.now();
    final firstDayOfWeek = today.subtract(Duration(days: today.weekday - 1));
    days =
        List.generate(7, (index) => firstDayOfWeek.add(Duration(days: index)));
    print(days);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Calendars',
            style: TextStyle(fontSize: 24),
          ),
          actions: [const Icon(Icons.search), const SizedBox(width: 12)],
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
        itemCount: 7,
        itemBuilder: (context, index) {
          final day = days[index];
          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DayDetailPage(day: day),
              ));

              refreshCalendars();
            },
            child: CalendarCardWidget(day: day, index: index),
          );
        },
      );
}
