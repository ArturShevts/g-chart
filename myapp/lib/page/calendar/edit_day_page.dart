import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/core/utils/local_Item_converter.dart';
import 'package:myapp/model/list_instance.dart';
import 'package:myapp/model/local_item.dart';
import 'package:myapp/widget/calendar/list_form.dart';

class AddEditListPage extends StatefulWidget {
  final ListInstance? listInstance;
  final DateTime? day;
  const AddEditListPage({
    Key? key,
    this.day,
    this.listInstance,
  }) : super(key: key);
  @override
  _AddEditListPageState createState() => _AddEditListPageState();
}

class _AddEditListPageState extends State<AddEditListPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;
  late bool isPublic;
  late bool isTemplate;
  late List<bool> repeatOn;
  late int repeatEvery;
  late List<LocalItem> localItems = [];

  @override
  void initState() {
    super.initState();

    title = widget.listInstance?.title ?? '';
    description = widget.listInstance?.description ?? '';
    isPublic = widget.listInstance?.isPublic ?? false;
    isTemplate = widget.listInstance?.isTemplate ?? false;
    repeatOn = widget.listInstance?.repeatOn ??
        [false, false, false, false, false, false, false];
    repeatEvery = widget.listInstance?.repeatEvery != null
        ? widget.listInstance!.repeatEvery!
        : 0;

    LocalItemConverter.instance
        .listItemToLocalItem(widget.listInstance?.listItems ?? [])
        .then((value) => localItems = value);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Hero(
          tag: 'hero${widget.listInstance?.id}',
          child: Form(
            key: _formKey,
            child: ListInstanceFormWidget(
              title: title,
              description: description,
              isPublic: isPublic,
              isTemplate: isTemplate,
              repeatOn: repeatOn,
              repeatEvery: repeatEvery,
              localItems: localItems,
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onChangedIsPublic: (isPublic) =>
                  setState(() => this.isPublic = isPublic),
              onChangedIsTemplate: (isTemplate) =>
                  setState(() => this.isTemplate = isTemplate),
              onChangedRepeatOn: (repeatOn) =>
                  setState(() => this.repeatOn = repeatOn),
              onChangedRepeatEvery: (repeatEvery) =>
                  setState(() => this.repeatEvery = repeatEvery),
              onChangedLocalItems: (localItems) =>
                  setState(() => this.localItems = localItems),
            ),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateListInstance,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateListInstance() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.listInstance != null;

      if (isUpdating) {
        await updateListInstance();
      } else {
        await addListInstance();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateListInstance() async {
    // final listInstance = widget.listInstance!.copy(
    //   isImportant: isImportant,
    //   number: number,
    //   title: title,
    //   description: description,
    // );

    // await ListInstancesDatabase.instance.update(listInstance);
  }

  Future addListInstance() async {
    // final listInstance = ListInstance(
    //   title: title,
    //   isImportant: true,
    //   number: number,
    //   description: description,
    //   createdTime: DateTime.now(),
    // );

    // await ListInstancesDatabase.instance.create(listInstance);
  }
}
