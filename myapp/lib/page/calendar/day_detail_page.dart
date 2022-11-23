import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/db/services/list_item_service.dart';
import 'package:myapp/model/list_instance.dart';
import 'package:myapp/model/list_item.dart';
// import '../../db/day/days_database.dart';
// import '../../model/day.dart';
import 'edit_day_page.dart';

class DayDetailPage extends StatefulWidget {
  final DateTime day;
  final List<ListInstance> listInstances;

  const DayDetailPage({
    Key? key,
    required this.day,
    required this.listInstances,
  }) : super(key: key);

  @override
  _DayDetailPageState createState() => _DayDetailPageState();
}

class PopulatedList {
  List<ListItem> items = [];
  late ListInstance details;
}

class _DayDetailPageState extends State<DayDetailPage> {
  late DateTime day = widget.day;
  late List<PopulatedList> populatedLists = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshItems();
  }

  Future refreshItems() async {
    setState(() => isLoading = true);
    for (var element in widget.listInstances) {
      List<ListItem> items =
          await ListItemsService.instance.readListItemsForListId(element.id!);

      final populatedList = PopulatedList();
      populatedList.items = items;
      populatedList.details = element;
      populatedLists.add(populatedList);
    }

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
                    Column(
                      children: populatedLists
                          .map((list) => Card(
                                color: Colors.amber.shade100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${list.details.title}, ',
                                          style: TextStyle(
                                              color: Colors.grey.shade900,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${list.details.description}',
                                          style: TextStyle(
                                              color: Colors.grey.shade800,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    ...list.items.map((item) => Row(children: [
                                          Text(item.exerciseId.toString()),
                                          Text(item.sets.toString()),
                                        ]))
                                  ]),
                                ),
                              ))
                          .toList(growable: false),
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

        // refreshDay();
      });

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          // await DaysDatabase.instance.delete(widget.dayId);

          Navigator.of(context).pop();
        },
      );
}
