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
  ListItem item;
  Exercise? exercise;
  String? displayString;
  LocalItem({required this.item, this.exercise, this.displayString});
}

class _ListItemsFormState extends State<ListItemsForm> {
  List<LocalItem> listItems = [];
  bool displaySecondLine = false;
  IconData displayIcon = Icons.drag_handle;

  ListItem emptyListItem = ListItem(
    userId: 0,
    listInstanceId: 0,
    exerciseId: 0,
    isCompleted: false,
    orderNum: 0,
  );

  @override
  void initState() {
    var emptyListItem1 = emptyListItem.copy(exerciseId: 1);
    var emptyListItem2 = emptyListItem.copy(exerciseId: 2);
    var emptyListItem3 = emptyListItem.copy(exerciseId: 3);
    var emptyListItem4 = emptyListItem.copy(exerciseId: 4);

    listItems = [
      LocalItem(
          item: emptyListItem1,
          exercise: null,
          displayString: 'dumbell 3 x 10 reps'),
      LocalItem(
          item: emptyListItem2,
          exercise: null,
          displayString: 'dumbell 2 x 10 reps'),
      LocalItem(
          item: emptyListItem3,
          exercise: null,
          displayString: 'dumbell 4 x 10 reps'),
      LocalItem(
          item: emptyListItem4,
          exercise: null,
          displayString: 'dumbell 1 x 10 reps'),
    ];

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
              key: Key('$index'),
              item: listItems[index].item,
              itemIndex: index,
              itemString: listItems[index].displayString ?? '',
              onCreate: (item) => setState(() {
                listItems.addAll(
                    [LocalItem(item: item), LocalItem(item: emptyListItem)]);

                displayIcon = getIcon(item.exercise?.category);
              }),
              onInputChanged: (description) => setState(() {
                print("changed description to $description");
                listItems[index].displayString = description;
              }),
            ),
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
class ListItemInput extends StatelessWidget {
  ListItem item;
  int itemIndex;
  final String itemString;
  final ValueChanged<String> onInputChanged;
  final ValueChanged<ListItem> onCreate;
  var exercises = <Exercise>[];

  ListItemInput({
    Key? key,
    required this.item,
    required this.itemIndex,
    required this.itemString,
    required this.onInputChanged,
    required this.onCreate,
  }) : super(key: key);

  Future searchExercisesByName(String name) async {
    exercises = await ExercisesService.instance.searchExercisesByName(name);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: itemString);
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));

    print("Building item $itemIndex");

    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        TextField(
          controller: controller,
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
            searchExercisesByName(value);
            print(exercises);
          },
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.white70),
            hintText: "Add exercise ${item.exerciseId}",
            border: InputBorder.none,
            prefixIcon: ReorderableDragStartListener(
              index: itemIndex,
              child: GestureDetector(
                child: const Icon(Icons.drag_handle),
                onTapDown: (details) {
                  // what to do when moving the item
                  onInputChanged(controller.text);
                  FocusScope.of(context).unfocus();
                  controller.clear();
                  print("tapped");
                },
              ),
            ),
          ),
        ),
        // if (exercises.isNotEmpty)
        Positioned(
          top: 50,
          left: 50,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(5),
            ),
            height: (20 + 30 * exercises.length).toDouble(),
            width: 200,
            child: ListView.builder(
              itemCount: exercises.length > 4 ? 4 : exercises.length,
              itemBuilder: (context, index) {
                String name = exercises[index].name;

                return InkWell(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          //if category is strenth show icon
                          getIcon(exercises[index].category),
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        exercises[index].name,
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    //wait a second before calling
                    // Future.delayed(const Duration(milliseconds: 100), () {
                    //   selectExercise(name);
                    // });
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// class ListItemInput extends StatefulWidget {
//   ListItem? item;
//   int itemIndex;
//   String? itemString;
//   ValueChanged<String> onInputChanged;
//   final ValueChanged<ListItem> onCreate;

//   ListItemInput({
//     required this.itemIndex,
//     required this.onInputChanged,
//     required this.onCreate,
//     this.itemString,
//     super.key,
//     this.item,
//   });

//   @override
//   State<ListItemInput> createState() => _ListItemInputState();
// }

// class _ListItemInputState extends State<ListItemInput> {
//   late ValueChanged<String> onInputChanged;

//   late List<Exercise> exercises = [];
//   late Exercise? selectedExercise;
//   late String? selectedExerciseInput = '';
//   late String? itemString;
//   late TextEditingController _controller = TextEditingController();
//   @override
//   // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => true;
//   @override
//   void initState() {
//     super.initState();

//     ListItem? item = widget.item;
//     selectedExercise = null;
//     print(widget.itemString);
//     _controller = TextEditingController(text: widget.itemString);

//     if (item != null || item!.exerciseId != 0) {
//       // getExercise();
//     } else {
//       selectedExerciseInput = '';
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: _controller,
//       // onEditingComplete:
//       //     //what to do  when editing is complete
//       //     createListItem,
//       textAlignVertical: TextAlignVertical.center,
//       textInputAction: () {
// // what to do when the user presses the done button on the keyboard

//         // createListItem();
//         return TextInputAction.next;
//       }(),
//       style: const TextStyle(
//         color: Colors.white,
//       ),
//       onChanged: onInputChanged,
//       // (value) {
//       //   // what to do when typing
//       //   // searchExercisesByName(value);
//       //   widget.onInputChanged = value;
//       //   setState(() {
//       //     widget.onInputChanged = value;
//       //   });
//       // }
//       // ,
//       decoration: InputDecoration(
//         hintStyle: const TextStyle(color: Colors.white70),
//         hintText: "Add exercise ${widget.item?.exerciseId}",
//         border: InputBorder.none,
//         prefixIcon: ReorderableDragStartListener(
//           index: widget.itemIndex,
//           child: GestureDetector(
//             child: const Icon(Icons.drag_handle),
//             onTapDown: (details) {
//               // what to do when moving the item

//               FocusScope.of(context).unfocus();
//               _controller.clear();
//               print("tapped");
//             },
//           ),
//         ),
//       ),
//     );

//     // return Stack(
//     //   children: [
//     // return TextField(
//     //   onEditingComplete: createListItem,
//     //   textAlignVertical: TextAlignVertical.center,
//     //   textInputAction: TextInputAction.next,
//     //   style: const TextStyle(
//     //     color: Colors.white,
//     //   ),
//     //   controller: _controller,
//     //   decoration: InputDecoration(
//     //     hintStyle: const TextStyle(color: Colors.white70),
//     //     hintText: "Add exercise ${widget.itemIndex}",
//     //     border: InputBorder.none,
//     //   ),
//     //   onChanged: (value) {
//     //     searchExercisesByName(value);
//     //     setState(() {
//     //       selectedExerciseInput = value;
//     //     });
//     //   },
//     // );
    // const SizedBox(height: 40, width: 300),
    // if (exercises.isNotEmpty)
    //   Container(
    //     padding: const EdgeInsets.all(8),
    //     decoration: BoxDecoration(
    //       color: Colors.black54,
    //       borderRadius: BorderRadius.circular(5),
    //     ),
    //     margin: const EdgeInsets.only(top: 50),
    //     height: 300,
    //     width: 200,
    //     child: ListView.builder(
    //       itemCount: exercises.length > 4 ? 4 : exercises.length,
    //       itemBuilder: (context, index) {
    //         String name = exercises[index].name;

    //         return InkWell(
    //           child: Row(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Icon(
    //                   //if category is strenth show icon
    //                   getIcon(exercises[index].category),
    //                   color: Colors.white,
    //                 ),
    //               ),
    //               Text(
    //                 exercises[index].name,
    //                 style: const TextStyle(
    //                   color: Colors.white70,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           onTap: () {
    //             //wait a second before calling
    //             Future.delayed(const Duration(milliseconds: 100), () {
    //               selectExercise(name);
    //             });
    //           },
    //         );
    //       },
    //     ),
    //   ),
//     //   ],
//     // );
//   }
// }




//   // void selectExercise(String ex) async {
//   //   for (var element in exercises!) {
//   //     if (element.name == ex) {
//   //       setState(() {
//   //         selectedExercise = element;
//   //         _controller.value = _controller.value.copyWith(
//   //           text: element.name,
//   //           selection: TextSelection.collapsed(offset: element.name.length),
//   //         );

//   //         exercises = [];
//   //       });
//   //     }
//   //   }
//   // }

//   // void getExercise() {
//   //   ExercisesService.instance
//   //       .readExercise(widget.item!.exerciseId)
//   //       .then((value) {
//   //     setState(() {
//   //       selectedExercise = value;
//   //       print("exercise SEleced: ${selectedExercise!.name}");
//   //     });
//   //   });
//   // }

//   // Future searchExercisesByName(String name) async {
//   //   return await ExercisesService.instance
//   //       .searchExercisesByName(name)
//   //       .then((value) {
//   //     setState(() {
//   //       exercises = value;
//   //     });
//   //   }).then((value) => value);
//   // }











  
//   // createListItem() async {
//   //   ListItem? item = widget.item;
//   //   if (selectedExercise != null) {
//   //     print(jsonEncode(item) + jsonEncode(selectedExercise));

//   //     if (item != null) {
//   //       item.copy(
//   //         exerciseId: selectedExercise!.id,
//   //         listInstanceId: 0,
//   //         userId: 0,
//   //         quantity: 0,
//   //         sets: 0,
//   //         weight: 0,
//   //         isCompleted: false,
//   //         orderNum: 0,

//   //         /// handle order num
//   //       );
//   //       widget.onCreate(item);
//   //     } else {
//   //       item = ListItem(
//   //         exerciseId: selectedExercise!.id!,
//   //         listInstanceId: 0,
//   //         userId: 0,
//   //         quantity: 0,
//   //         sets: 0,
//   //         weight: 0,
//   //         isCompleted: false,
//   //         orderNum: 0,

//   //         /// handle order num
//   //       );
//   //       widget.onCreate(item);
//   //     }
//   //   }
//   // }
