import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myapp/db/services/exercises_service.dart';
import 'package:myapp/model/events.dart';
import 'package:myapp/model/exercises.dart';
import 'package:myapp/model/list_instance.dart';
import 'package:myapp/model/list_item.dart';

class ListItemsForm extends StatefulWidget {
  final ListInstance? listInstance;
  List<ListItem>? listItems = [];
  ListItemsForm({super.key, this.listInstance, this.listItems});

  @override
  State<ListItemsForm> createState() => _ListItemsFormState();
}
//

getIcon(String? category) {
  switch (category) {
    case 'strength':
      return Icons.fitness_center;
    case 'strongman':
      return Icons.circle;
    case 'stretching':
      return Icons.self_improvement;
    case 'cardio':
      return Icons.directions_run;
    case 'dynamic':
      return Icons.sports_gymnastics_rounded;
    default:
      return Icons.drag_handle;
  }
}

class LocalItem {
  String exerciseId;
  String exerciseName;
  String displayString;
  String reps;
  String weight;
  String quantity;

  LocalItem(
      {required this.exerciseId,
      required this.displayString,
      required this.exerciseName,
      required this.reps,
      required this.weight,
      required this.quantity});
}

class _ListItemsFormState extends State<ListItemsForm> {
  List<LocalItem> listItems = [];
  LocalItem emptyLocalItem = LocalItem(
      exerciseId: '',
      exerciseName: '',
      displayString: '',
      reps: '',
      weight: '',
      quantity: '');

  @override
  // TODO: implement context
  BuildContext get context => super.context;
  bool displaySecondLine = false;

  @override
  void initState() {
    listItems = [emptyLocalItem];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: ReorderableListView(
        children: <Widget>[
          for (int index = 0; index < listItems.length; index += 1)
            ListItemInput(
              key: UniqueKey(),
              itemIndex: index,
              inputData: listItems[index],
              onClickOut: (value) {
                setState(() {
                  listItems[index].displayString = value.displayString;
                });
              },
              onRemove: (value) {
                setState(() {
                  listItems.removeAt(index);
                });
              },
              onClickEnter: (item) {
                setState(() {
                  listItems[index] = item;
                  listItems.insert(index + 1, emptyLocalItem);
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
          });
        }),
      ),
    );
  }
}

//
//
//
//++++++++++++++++++++++++++++++++++++++++ITEM INPUT+++++++++++++++++++++++++++++++++++++++++++++++
class ListItemInput extends StatefulWidget {
  LocalItem inputData;
  int itemIndex;
  final ValueChanged<LocalItem> onInputValid;
  final ValueChanged<LocalItem> onClickEnter;
  final ValueChanged<LocalItem> onMove;
  final ValueChanged<LocalItem> onClickOut;
  final ValueChanged<LocalItem> onRemove;

  ListItemInput({
    Key? key,
    required this.inputData,
    required this.itemIndex,
    required this.onInputValid,
    required this.onClickEnter,
    required this.onMove,
    required this.onClickOut,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<ListItemInput> createState() => _ListItemInputState();
}

class _ListItemInputState extends State<ListItemInput>
    with TickerProviderStateMixin {
  List<Exercise> exercises = [];
  late LocalItem inputData;

  TextEditingController fieldController = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  GlobalKey globalKey = GlobalKey();
  OverlayState? _overlayState;

  @override
  void initState() {
    print("init item state ${widget.itemIndex} ${widget.key}");

    super.initState();
    inputData = widget.inputData;
//focus

    FocusManager.instance.primaryFocus == null
        ? FocusScope.of(context).requestFocus(_focusNode)
        : null;

    //overlay
    _overlayState = Overlay.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      globalKey;
    });
    _focusNode.addListener(() {
      print("focus node ${_focusNode.hasFocus}");
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlay();

        _overlayState?.insert(_overlayEntry!);
      } else {
        print("remove overlay because focus node ${_focusNode.nearestScope}");

        _overlayEntry!.remove();
        _overlayState?.insert(_overlayEntry!);
      }
    });
    //controller
    fieldController =
        TextEditingController(text: widget.inputData.displayString);
    fieldController.selection = TextSelection.fromPosition(
        TextPosition(offset: fieldController.text.length));
    print("Building item ${widget.itemIndex}");
  }

  Future searchExercisesByName(String name) async {
    var res = await ExercisesService.instance.searchExercisesByName(name);
    // setExerciseState(res);
    setState(() {
      exercises = res;
      _overlayEntry = _createOverlay();

      _overlayState?.insert(_overlayEntry!);
    });
  }

  void selectExercise(String ex) async {
    for (var element in exercises) {
      if (element.name == ex) {
        setState(() {
          exercises = [];

          _overlayEntry?.remove();
          fieldController.text = element.name;
          fieldController.selection = TextSelection.fromPosition(
              TextPosition(offset: fieldController.text.length));
          _focusNode.requestFocus();
          inputData.exerciseId = element.id.toString();
          inputData.exerciseName = element.name;

          widget.onInputValid(inputData);
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("tapped1");
    // _focusNode.dispose();
    // _overlayEntry?.remove();
    // _overlayState?.dispose();

    super.dispose();
  }

  OverlayEntry _createOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;
    return OverlayEntry(
        builder: (context) => Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + 5.0),
                child: Material(
                  color: Colors.black87,
                  child: Column(
                    children: [
                      for (var i = 0; i < exercises.length && i < 4; i++)
                        ListTile(
                          onLongPress: () => selectExercise(exercises[i].name),
                          onTap: () => selectExercise(exercises[i].name),
                          visualDensity: VisualDensity(vertical: -2),
                          dense: true,
                          leading: Icon(
                            //if category is strenth show icon
                            getIcon(exercises[i].category),
                            color: Colors.white,
                          ),
                          title: Text(
                            exercises[i].name,
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        onSubmitted: (value) {
          inputData.displayString = value;
          widget.onClickEnter(inputData);
        },
        onTapOutside: (event) {},
        keyboardType: TextInputType.text,
        maxLines: null,
        focusNode: _focusNode,
        controller: fieldController,
        onEditingComplete: () {
          print("onEditingComplete");
          FocusScope.of(context).nextFocus();

          // onInputChanged(controller.text);
        },
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.next,
        style: const TextStyle(
          color: Colors.white,
        ),
        onChanged: (value) {
          if (inputData.displayString.isNotEmpty) {
            if (value.contains(inputData.displayString)) {
              var cutValue =
                  value.substring(inputData.displayString.length, value.length);
              var sets = cutValue.split(RegExp(r'[^0-9]')).first;
              var reps = cutValue.split(RegExp(r'[^0-9]')).elementAt(1);
              var weight = cutValue.split(RegExp(r'[^0-9]')).last;
            } else {
              setState(() {
                inputData.exerciseId = '';
              });
            }

            // regex extract number from string after Substring
          }

          if (value.length > 1) {
            searchExercisesByName(value);
          }
        },
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.white70),
          hintText: "Add exercise",
          border: InputBorder.none,
          prefixIcon: ReorderableDragStartListener(
            index: widget.itemIndex,
            child: GestureDetector(
              child: const Icon(Icons.drag_handle),
              onTapDown: (details) {
                // what to do when moving the item
                inputData.displayString = fieldController.text;
                widget.onMove(inputData);
                // FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
          ),
        ),
      ),
    );
  }
}
