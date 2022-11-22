import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import '../../db/day/days_database.dart';
// import '../../model/day.dart';
import 'edit_day_page.dart';

class DayDetailPage extends StatefulWidget {
  final DateTime day;

  const DayDetailPage({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  _DayDetailPageState createState() => _DayDetailPageState();
}

class _DayDetailPageState extends State<DayDetailPage> {
  late DateTime day = widget.day;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshDay();
  }

  Future refreshDay() async {
    setState(() => isLoading = true);

    // this.day = await DaysDatabase.instance.readDay(widget.dayId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      day.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      day.toString(),
                      style: TextStyle(color: Colors.white38),
                    ),
                    SizedBox(height: 8),
                    Text(
                      day.toString(),
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    )
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        // await Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => AddEditDayPage(day: day),
        // ));

        refreshDay();
      });

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          // await DaysDatabase.instance.delete(widget.dayId);

          Navigator.of(context).pop();
        },
      );
}
