import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/db/services/exercises_service.dart';
import 'package:myapp/db/services/list_instance_service.dart';
import 'package:myapp/db/services/list_item_service.dart';
import 'package:myapp/model/exercises.dart';
import 'package:myapp/model/list_instance.dart';
import 'package:myapp/model/list_item.dart';
import 'package:myapp/widget/calendar/new_list_modal.dart';
// import '../../db/day/days_database.dart';
// import '../../model/day.dart';
import 'edit_list_page.dart';

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

class _DayDetailPageState extends State<DayDetailPage> {
  late DateTime day = widget.day;
  late List<ListInstance> populatedLists = [];
  late List<Exercise> exercises = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshItems();
  }

  Future refreshItems() async {
    setState(() => isLoading = true);
    populatedLists = [];
    for (var element in widget.listInstances) {
      final populatedList = await ListInstancesService.instance
          .readPopulatedListInstance(element.id!);
      populatedLists.add(populatedList);
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            addButton(),
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
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
                                        Expanded(
                                          child: Text(
                                            '${list.title}',
                                            style: TextStyle(
                                                color: Colors.grey.shade900,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),

                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Expanded(
                                            child: editButton(list),
                                          ),
                                        )
                                        //
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${list.description} ',
                                            style: TextStyle(
                                                color: Colors.grey.shade800,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    ...?list.listItems?.map((item) {
                                      return Row(
                                        children: [
                                          Text(
                                            (item.sets != null &&
                                                        item.quantity != null
                                                    ? '${item.quantity} x ${item.sets} Sets '
                                                    : "") +
                                                (item.weight != null &&
                                                        item.weight != 0
                                                    ? '${item.weight}kg '
                                                    : ''),
                                            style: TextStyle(
                                                color: Colors.grey.shade800,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            item.exercise?.name ?? '',
                                            style: TextStyle(
                                                color: Colors.grey.shade900,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      );
                                    }).toList()
                                  ]),
                                ),
                              ))
                          .toList(growable: false),
                    )
                  ],
                ),
              ),
      );

  Widget addButton() => IconButton(
      icon: const Icon(Icons.playlist_add_rounded),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditListPage(day: day),
        ));

        refreshItems();
      });

  Widget editButton(ListInstance list) => IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditListPage(day: day, listInstance: list),
        ));

        refreshItems();
      });
}
