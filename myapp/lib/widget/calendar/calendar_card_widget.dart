import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/model/list_instance.dart';

final _lightColors = [
  Colors.amber.shade100,
  Colors.lightGreen.shade100,
  Colors.lightBlue.shade100,
  Colors.orange.shade100,
  Colors.pink.shade100,
  Colors.teal.shade100
];

class CalendarCardWidget extends StatelessWidget {
  CalendarCardWidget({
    Key? key,
    required this.day,
    required this.index,
    required this.listInstances,
  }) : super(key: key);

  final DateTime day;
  final int index;
  final List<ListInstance> listInstances;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    final minHeight = getMinHeight(index);

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  //dateformat Weekday Month Day
                  '${DateFormat('EEEE').format(day)}, ',
                  style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  //dateformat Weekday Month Day
                  DateFormat('MMMd').format(day),
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 4),
            //if (listInstances.length > 0) display  listInstances title else display "No List Instances"
            if (listInstances.length > 0)
              Column(
                children: [
                  for (var i = 0; i < listInstances.length; i++)
                    Row(children: [
                      Text(
                        '${listInstances[i].title} ',
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: 18,
                          decorationStyle: TextDecorationStyle.solid,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.fitness_center,
                        color: Colors.grey.shade900,
                        size: 20,
                      ),
                    ]),
                ],
              )
            else
              Row(children: [
                Text(
                  'Rest Day ',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 18,
                  ),
                ),
                Icon(
                  Icons.hotel,
                  color: Colors.grey.shade800,
                  size: 20,
                ),
              ]),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 100;
      case 2:
        return 100;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
