import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/db/services/exercises_service.dart';
import 'package:myapp/model/exercises.dart';
import 'package:myapp/model/local_item.dart';

import '../../core/utils/input_formatter.dart';

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
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlay();
        _overlayState?.insert(_overlayEntry!);
      } else {
        _overlayEntry!.remove();
        _overlayState?.insert(_overlayEntry!);
      }
    });

    //controller
    fieldController =
        TextEditingController(text: widget.inputData.displayString);
    fieldController.selection = TextSelection.fromPosition(
        TextPosition(offset: fieldController.text.length));
    //focus
    if (widget.activeIndex) {
      _focusNode.requestFocus();
      widget.activeIndex = false;
    }

    if (_focusNode.hasFocus) {
      SystemChannels.textInput.invokeMethod('TextInput.show');
    }
  }

  Future searchExercisesByName(String name) async {
    var res = await ExercisesService.instance.searchExercisesByName(name);

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
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
        onChanged: (value) {
          parseInput(value);

          if (value.length > 1) {
            searchExercisesByName(value);
          }
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
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.white70),
          hintText: "Add exercise",
          border: InputBorder.none,
          prefixIcon: ReorderableDragStartListener(
            index: widget.itemIndex,
            child: GestureDetector(
              child: const Icon(Icons.drag_handle),
              onTapDown: (details) {
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
