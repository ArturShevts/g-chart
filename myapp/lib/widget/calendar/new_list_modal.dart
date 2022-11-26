import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:myapp/db/services/list_instance_service.dart';
import 'package:myapp/model/list_instance.dart';

//sections:
// - title: "Add List"
// - search button to redirect to another search modal
// - input fild to add new list
// -- list name
// -- list discription
// -- list categories (dropdown) (multiple selections) (optional) (default: none) (can be added later)
// -- list tags (dropdown) (multiple selections) (optional) (default: none) (can be added later)
// -- list repeat radio buttons (optional) (default: none) (can be added later)
// -- list repeat frequency if repeat radio is selected (optional) (default: none) (can be added later)
// --- if repeat list repeat weekday radios (optional) (default: none) (can be added later)
// --- if repeat list repeat start date (optional) (default: none) (can be added later)
// --- if repeat list repeat end date  (optional) (default: none) (can be added later)

class AddListInstanceModelButton extends StatefulWidget {
  final DateTime day;
  //  user
  final int userId;
  const AddListInstanceModelButton({
    required this.day,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  State<AddListInstanceModelButton> createState() =>
      _AddListInstanceModelButtonState();
}

class _AddListInstanceModelButtonState
    extends State<AddListInstanceModelButton> {
  @override
  Widget build(BuildContext context) {
    DateTimeRange selectedDate = DateTimeRange(
      start: widget.day,
      end: widget.day,
    );

    ListInstance formGroup = ListInstance(
      title: "",
      userId: widget.userId,
      createdTime: DateTime.now(),
      isCompleted: false,
      isPublic: false,
      isTemplate: false,
    );

    _selectDate(BuildContext context) async {
      final DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
          formGroup.startedTime = selectedDate.start;
          formGroup.finishedTime = selectedDate.end;
        });
      }
    }

    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet<void>(
          // isScrollControlled: true,
          constraints: const BoxConstraints(),
          enableDrag: true,
          //context global context
          context: context,
          // height: MediaQuery.of(context).size.height * 0.4,
          builder: (BuildContext context) {
            return Container(
              // height: height * 0.7,
              height: 950,
              child: Column(
                children: [
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Add List',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ))),
                  Expanded(
                    child: SizedBox(
                      child: ListView(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Workout Name',
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Description',
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Categories',
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Tags',
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Repeat workout?',
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Repeat Frequency',
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Repeat on Weekdays',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => _selectDate(context),
                              style: ElevatedButton.styleFrom(),
                              child: const Text(
                                'Select dates',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  // ListInstancesService.instance.create(
                                  //   ListInstance(
                                  //       userId: userId,
                                  //       listId: 1,
                                  //       date: day,
                                  //       completed: false),
                                  // );
                                  Navigator.pop(context);
                                },
                                child: const Text('Add Exercises')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
