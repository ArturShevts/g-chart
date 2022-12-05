import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String sets;

  LocalItem({
    required this.exerciseId,
    required this.displayString,
    required this.exerciseName,
    required this.reps,
    required this.weight,
    required this.sets,
  });

  LocalItem copy(
          {String? exerciseId,
          String? exerciseName,
          String? displayString,
          String? reps,
          String? weight,
          String? sets,
          bool? selected}) =>
      LocalItem(
        exerciseId: exerciseId ?? this.exerciseId,
        exerciseName: exerciseName ?? this.exerciseName,
        displayString: displayString ?? this.displayString,
        reps: reps ?? this.reps,
        weight: weight ?? this.weight,
        sets: sets ?? this.sets,
      );
}

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
  // TODO: implement context
  BuildContext get context => super.context;
  bool displaySecondLine = false;

  @override
  void initState() {
    var emptyItem = emptyLocalItem.copy();

    listItems = [emptyItem];
    var activeIndex = listItems.length - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              print("HIDE!!!!!!!!!!");
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
                    });
                  },
                  onClickEnter: (item) {
                    setState(() {
                      listItems[index] = item;
                      var newItem = emptyLocalItem.copy();
                      listItems.insert(index + 1, newItem);
                      activeIndex = index + 1;
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
        ),
      ],
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
  bool activeIndex;

  final ValueChanged<LocalItem> onInputValid;
  final ValueChanged<LocalItem> onClickEnter;
  final ValueChanged<LocalItem> onMove;
  final ValueChanged<LocalItem> onClickOut;
  final ValueChanged<LocalItem> onRemove;

  ListItemInput({
    Key? key,
    required this.activeIndex,
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
  int? activeIndex;

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

    if (widget.activeIndex) {
      print("focus node ${_focusNode.hasFocus}");
      _focusNode.requestFocus();
      widget.activeIndex = false;
    }

    if (_focusNode.hasFocus) {
      SystemChannels.textInput.invokeMethod('TextInput.show');
    }
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

  void parseInput(String value) {
    final intInStr = RegExp(r'\d+');
    var sets = RegExp(r"(\d+) Sets").firstMatch(value)?.group(1);
    var reps = RegExp(r"(\d+) Reps").firstMatch(value)?.group(1);
    var weight = RegExp(r"(\d+) Kg").firstMatch(value)?.group(1);
    setState(() {
      if (sets != null) {
        inputData.sets = intInStr.firstMatch(sets)?.group(0) ?? "";
      } else {
        inputData.sets = "";
      }
      if (reps != null) {
        inputData.reps = intInStr.firstMatch(reps)?.group(0) ?? "";
      } else {
        inputData.reps = "";
      }
      if (weight != null) {
        inputData.weight = intInStr.firstMatch(weight)?.group(0) ?? "";
      } else {
        inputData.weight = "";
      }
    });
  }

  @override
  void dispose() {
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
          SystemChannels.textInput.invokeMethod('TextInput.show');

          inputData.displayString = value;
          widget.onClickEnter(inputData);
        },
        onTapOutside: (event) {
          if (_overlayState == null) {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          }
          widget.onClickOut(inputData);
        },
        keyboardType: TextInputType.text,
        maxLines: null,
        focusNode: _focusNode,
        inputFormatters: [
          SetsRepsWeightTextInputFormatter(
              exerciseString: inputData.exerciseName,
              isReps: inputData.reps,
              isSets: inputData.sets,
              isWeight: inputData.weight)
        ],

        controller: fieldController,
        onEditingComplete: () {
          print("onEditingComplete");
          FocusScope.of(context).nextFocus();

          // onInputChanged(controller.text);
        },
        textAlignVertical: TextAlignVertical.center,
        // textInputAction: TextInputAction.next,
        style: const TextStyle(
          color: Colors.white,
        ),
        onChanged: (value) {
          parseInput(value);

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
                _focusNode.unfocus();
              },
            ),
          ),
        ),
      ),
    );
  }
}

// var cutValue =
//                 value.substring(inputData.displayString.length, value.length);
//             var sets = cutValue.split(RegExp(r'[^0-9][x]')).first
//             var reps = cutValue.split(RegExp(r'[^0-9][x]')).elementAt(1);
//             var weight = cutValue.split(RegExp(r'[^0-9][x]')).last;

class SetsRepsWeightTextInputFormatter extends TextInputFormatter {
  final String exerciseString;
  final String isWeight;
  final String isReps;
  final String isSets;

  SetsRepsWeightTextInputFormatter({
    required this.exerciseString,
    required this.isWeight,
    required this.isReps,
    required this.isSets,
  }) {
    assert(exerciseString != null);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = oldValue.text;

    if (exerciseString.isNotEmpty) {
//'${newValue.text.split(sets).first} $_sets Sets X'

      if (value.contains(exerciseString)) {
        var cutValue = value.substring(exerciseString.length, value.length);

        var match = RegExp(r'[0-9]+x').allMatches(cutValue).isNotEmpty
            ? RegExp(r'[0-9]+x').allMatches(cutValue).last.group(0)!
            : '';
        if (match.isNotEmpty) {
          final intInStr = RegExp(r'\d+');

          var matchQt = intInStr.firstMatch(match)?.group(0) ?? '';
          var matchType = 'Sets';

          if (isSets.isNotEmpty) {
            matchType = 'Reps';
          }
          if (isReps.isNotEmpty) {
            matchType = 'Kg';
          }
          if (isWeight.isEmpty) {
            var textArr = value.split(match);
            print(jsonEncode(textArr));

            textArr.length > 1 ? textArr.removeLast() : null;
            print(jsonEncode(textArr));
            var newText = '${textArr.join()} $matchQt $matchType';
            newValue = TextEditingValue(
              text: newText,
              selection: newText.length == newText.length
                  ? TextSelection.collapsed(offset: newText.length)
                  : TextSelection.collapsed(offset: newText.length - 1),
            );
          }
        }
      }
    }

    if (isWeight.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        return oldValue;
      }
    }

    return newValue;
  }
}
