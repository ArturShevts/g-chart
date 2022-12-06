import 'package:flutter/material.dart';
import 'package:myapp/model/local_item.dart';
import 'package:myapp/widget/calendar/list_items_form.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:weekday_selector/weekday_selector.dart';

class ListInstanceFormWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final bool isPublic;
  final bool isTemplate;
  final List<bool>? repeatOn;
  final int? repeatEvery;
  final List<LocalItem>? localItems;
  final int? listInstanceId;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<bool> onChangedIsPublic;
  final ValueChanged<bool> onChangedIsTemplate;
  final ValueChanged<List<bool>> onChangedRepeatOn;
  final ValueChanged<int> onChangedRepeatEvery;
  final ValueChanged<List<LocalItem>> onChangedLocalItems;

  const ListInstanceFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    this.isPublic = false,
    this.isTemplate = false,
    this.repeatOn,
    this.repeatEvery,
    this.localItems,
    this.listInstanceId,
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedIsPublic,
    required this.onChangedIsTemplate,
    required this.onChangedRepeatOn,
    required this.onChangedRepeatEvery,
    required this.onChangedLocalItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Switch(
                    value: isTemplate,
                    onChanged: onChangedIsTemplate,
                  ),
                  const Text(
                    'Make List a Template?',
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              if (isTemplate)
                Row(
                  children: [
                    Switch(
                      value: isPublic,
                      onChanged: onChangedIsPublic,
                    ),
                    const Text(
                      'Make Template Public?',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              buildTitle(),
              const SizedBox(height: 8),
              buildDescription(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      repeatEvery == 0
                          ? repeatOn!.contains(true)
                              ? 'Repeat on days:'
                              : 'Never Repeat'
                          : 'Repeat every $repeatEvery days',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              buildRepeatOnWeekdays(),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Select Interval:",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              buildRepeatEvery(),
              const SizedBox(height: 8),
              ListItemsForm(
                  listInstanceId: listInstanceId,
                  localItems: localItems,
                  onChangedLocalItems: setState()),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Description...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );

  Widget buildRepeatOnWeekdays() => WeekdaySelector(
        onChanged: (day) {
          final index = day % 7;

          repeatOn![index] = !repeatOn![index];
          onChangedRepeatOn(repeatOn!);
          onChangedRepeatEvery(0);
        },
        values: repeatOn!,
      );

  Widget buildRepeatEvery() => NumberPicker(
        value: repeatEvery!,
        minValue: 0,
        maxValue: 63,
        onChanged: (value) {
          onChangedRepeatEvery(value);
          onChangedRepeatOn([false, false, false, false, false, false, false]);
        },
        axis: Axis.horizontal,
        textStyle: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        selectedTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        decoration: const BoxDecoration(
          // border: Border.all(color: Colors.white70),
          // borderRadius: BorderRadius.circular(12),
          backgroundBlendMode: BlendMode.lighten,
          color: Colors.blue,
        ),
      );
}
