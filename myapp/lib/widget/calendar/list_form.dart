import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:weekday_selector/weekday_selector.dart';

class ListInstanceFormWidget extends StatefulWidget {
  final String? title;
  final String? description;
  final bool isPublic;
  final bool isTemplate;
  final List<bool>? repeatOn;
  final int? repeatEvery;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<bool> onChangedIsPublic;
  final ValueChanged<bool> onChangedIsTemplate;
  final ValueChanged<List<bool>> onChangedRepeatOn;
  final ValueChanged<int> onChangedRepeatEvery;

  const ListInstanceFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    this.isPublic = false,
    this.isTemplate = false,
    this.repeatOn,
    this.repeatEvery,
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedIsPublic,
    required this.onChangedIsTemplate,
    required this.onChangedRepeatOn,
    required this.onChangedRepeatEvery,
  }) : super(key: key);

  @override
  State<ListInstanceFormWidget> createState() => _ListInstanceFormWidgetState();
}

class _ListInstanceFormWidgetState extends State<ListInstanceFormWidget> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Switch(
                  value: widget.isTemplate,
                  onChanged: widget.onChangedIsTemplate,
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
            if (widget.isTemplate)
              Row(
                children: [
                  Switch(
                    value: widget.isPublic,
                    onChanged: widget.onChangedIsPublic,
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
                    widget.repeatEvery == 0
                        ? widget.repeatOn!.contains(true)
                            ? 'Repeat on days:'
                            : 'Never Repeat'
                        : 'Repeat every ${widget.repeatEvery} days',
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
          ],
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: widget.title,
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
        onChanged: widget.onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: widget.description,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Description...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: widget.onChangedDescription,
      );

  Widget buildRepeatOnWeekdays() => WeekdaySelector(
        onChanged: (day) {
          final index = day % 7;

          widget.repeatOn![index] = !widget.repeatOn![index];
          widget.onChangedRepeatOn(widget.repeatOn!);
          widget.onChangedRepeatEvery(0);
        },
        values: widget.repeatOn!,
      );

  Widget buildRepeatEvery() => NumberPicker(
        value: widget.repeatEvery!,
        minValue: 0,
        maxValue: 63,
        onChanged: (value) {
          widget.onChangedRepeatEvery(value);
          widget.onChangedRepeatOn(
              [false, false, false, false, false, false, false]);
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
