import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/model/list_instance.dart';
import 'package:myapp/model/list_item.dart';
import 'package:myapp/model/local_item.dart';
import 'list_item.dart';

class ListItemsForm extends StatefulWidget {
  final int? listInstanceId;
  final List<LocalItem>? localItems;
  final ValueChanged<List<LocalItem>> onChangedLocalItems;

  List<ListItem>? listItems = [];
  ListItemsForm({
    super.key,
    this.listInstanceId,
    this.listItems,
    this.localItems,
    required this.onChangedLocalItems,
  });

  @override
  State<ListItemsForm> createState() => _ListItemsFormState();
}
//

class _ListItemsFormState extends State<ListItemsForm> {
  List<LocalItem> listItems = [];
  int? activeIndex;

  LocalItem emptyLocalItem = LocalItem(
    exerciseId: '',
    displayString: '',
    exerciseName: '',
    reps: '',
    weight: '',
    sets: '',
  );

  @override
  BuildContext get context => super.context;
  bool displaySecondLine = false;

  @override
  void initState() {
    super.initState();

    ValueNotifier<List<LocalItem>> _listItems =
        ValueNotifier<List<LocalItem>>(listItems);
    _listItems.addListener(() {
      print("listItems changed");
      widget.onChangedLocalItems(listItems);
    });

    var emptyItem = emptyLocalItem.copy();

    listItems = [emptyItem];
    activeIndex = listItems.length - 1;
  }

  void sendItems() {
    print(
        "sendItems called ${widget.localItems?.length}  and sent:${listItems.length}");
    widget.onChangedLocalItems(listItems);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            child: Container(
              height: 75,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: Text(
                  'Enter Exercises Below',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )),
        SizedBox(
          height: 600,
          child: ReorderableListView(
            children: <Widget>[
              for (int index = 0; index < listItems.length; index += 1)
                ListItemInput(
                  key: UniqueKey(),
                  itemIndex: index,
                  inputData: listItems[index],
                  activeIndex: () {
                    var i = activeIndex;
                    if (i == index && i != 0) {
                      setState(() {
                        activeIndex = null;
                      });
                      return true;
                    } else {
                      return false;
                    }
                  }(),
                  onClickOut: (value) {},
                  onRemove: (value) {
                    setState(() {
                      listItems.removeAt(index);
                      sendItems();
                    });
                  },
                  onClickEnter: (item) {
                    setState(() {
                      listItems[index] = item;
                      var newItem = emptyLocalItem.copy();
                      listItems.insert(index + 1, newItem);
                      activeIndex = index + 1;
                      sendItems();
                    });
                  },
                  onInputValid: (i) {},
                  onMove: (i) {},
                )
            ],
            onReorder: (oldIndex, newIndex) => setState(() {
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final LocalItem item = listItems.removeAt(oldIndex);
                listItems.insert(newIndex, item);
                sendItems();
              });
            }),
          ),
        ),
      ],
    );
  }
}
