import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/core/utils/local_Item_converter.dart';
import 'package:myapp/db/services/list_instance_service.dart';
import 'package:myapp/db/services/list_item_service.dart';
import 'package:myapp/model/list_instance.dart';
import 'package:myapp/model/list_item.dart';
import 'package:myapp/model/local_item.dart';
import 'package:myapp/widget/calendar/list_form.dart';

import '../../widget/calendar/list_items_form.dart';

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
  late ListInstance? listInstance = widget.listInstance;

  late String title;
  late String description;
  late bool isPublic;
  late bool isTemplate;
  late List<bool> repeatOn;
  late int? repeatEvery;
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

    print(
        "these are the items: ${widget.listInstance?.listItems?.length.toString()}");
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
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                Form(
                  key: _formKey,
                  child: ListInstanceFormWidget(
                    title: title,
                    description: description,
                    isPublic: isPublic,
                    isTemplate: isTemplate,
                    repeatOn: repeatOn,
                    repeatEvery: repeatEvery,
                    onChangedTitle: (title) =>
                        setState(() => this.title = title),
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
                  ),
                ),
                ListItemsForm(
                  listInstanceId: listInstance?.id,
                  localItems: localItems,
                  onChangedLocalItems: (items) {
                    print("onChangedLocalItems called by listitemsform $items");
                    setState(() {
                      localItems = items;
                    });
                  },
                ),
              ],
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
        onPressed: addOrUpdateList,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateList() async {
    print("clicked save ${localItems.length}");
    if (widget.listInstance != null) {
      updateList();
    } else {
      addList();
    }
  }

  Future updateList() async {
    print("Update edit_list_page ${localItems.length}");
    final ListInstance listInstance = widget.listInstance!.copy(
      title: title,
      description: description,
      isPublic: isPublic,
      isTemplate: isTemplate,
      isCompleted: false,
      repeatOn: repeatOn,
      repeatEvery: repeatEvery,
    );
    print("Update edit_list_page  ${listInstance.toJson()}");

    await ListInstancesService.instance.update(listInstance);
    List<ListItem> listItems = LocalItemConverter.instance
        .localItemToListItem(localItems, listInstance.id!);

    for (var i = 0; i < listItems.length; i++) {
      print("Update edit_list_page  item: ${listItems[i].toJson()}");

      await ListItemsService.instance.create(listItems[i]);
    }
  }

  Future addList() async {
    print("Add edit_list_page ${localItems.length}");

    final listInstanceDto = ListInstance(
      title: title,
      userId: 1,
      createdTime: DateTime.now(),
      description: description,
      isPublic: isPublic,
      isTemplate: isTemplate,
      isCompleted: false,
      repeatOn: repeatOn,
      repeatEvery: repeatEvery,
    );
    print("Add edit_list_page  ${listInstanceDto.toJson()}");

    ListInstance listInstance =
        await ListInstancesService.instance.create(listInstanceDto);

    List<ListItem> listItems = LocalItemConverter.instance
        .localItemToListItem(localItems, listInstance.id!);

    for (var i = 0; i < listItems.length; i++) {
      print("Add edit_list_page  item index: ${i}");

      await ListItemsService.instance.create(listItems[i]);
    }
  }
}

















  // Widget build(BuildContext context) => Scaffold(
  //       appBar: AppBar(
  //         actions: [buildButton()],
  //       ),
  //       body: Hero(
  //         tag: 'hero${widget.listInstance?.id}',
  //         child: SingleChildScrollView(
  //           child: Column(
  //             children: [
  //               Form(
  //                 key: _formKey,
  //                 child: ListInstanceFormWidget(
  //                     title: title,
  //                     description: description,
  //                     isPublic: isPublic,
  //                     isTemplate: isTemplate,
  //                     repeatOn: repeatOn,
  //                     repeatEvery: repeatEvery,
  //                     localItems: localItems,
  //                     onChangedTitle: (title) =>
  //                         setState(() => this.title = title),
  //                     onChangedDescription: (description) =>
  //                         setState(() => this.description = description),
  //                     onChangedIsPublic: (isPublic) =>
  //                         setState(() => this.isPublic = isPublic),
  //                     onChangedIsTemplate: (isTemplate) =>
  //                         setState(() => this.isTemplate = isTemplate),
  //                     onChangedRepeatOn: (repeatOn) =>
  //                         setState(() => this.repeatOn = repeatOn),
  //                     onChangedRepeatEvery: (repeatEvery) =>
  //                         setState(() => this.repeatEvery = repeatEvery),
  //                     onChangedLocalItems: (localItems) => {
  //                           print(
  //                               "setState in editDayPAge called ${localItems.length}"),
  //                           setState(() => this.localItems = localItems),
  //                         }),
  //               ),
  //               Expanded(
  //                 child: ListItemsForm(
  //                   listInstanceId: listInstance?.id,
  //                   localItems: localItems,
  //                   onChangedLocalItems: (items) {
  //                     print(
  //                         "onChangedLocalItems called by listitemsform $items");
  //                     setState(() {
  //                       localItems = items;
  //                     });
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );