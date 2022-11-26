import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:myapp/db/services/exercises_service.dart';
import 'package:myapp/db/services/list_item_service.dart';
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

class _ListItemsFormState extends State<ListItemsForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: Column(
        children: [
          // if (widget.listItems != null)
          //   for (var item in widget.listItems!) ListItemInput(item: null),
          ListItemInput(),
          ListItemInput(),

          ListItemInput(),
        ],
      ),
    );
  }
}

class ListItemInput extends StatefulWidget {
  ListItem? item;

  ListItemInput({
    super.key,
    this.item,
  });

  @override
  State<ListItemInput> createState() => _ListItemInputState();
}

class _ListItemInputState extends State<ListItemInput> {
  late List<Exercise>? exercises = [];
  late Exercise? selectedExercise;
  late String? selectedExerciseInput = '';
  void initState() {
    ListItem? item = widget.item;

    super.initState();

    if (item != null) {
      getExercise();
    } else {
      selectedExercise = null;
      selectedExerciseInput = '';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  createListItem() async {
    ListItem? item = widget.item;
    if (item == null && selectedExercise != null) {
      item = ListItem(
        exerciseId: selectedExercise!.id!,
        listInstanceId: widget.item!.listInstanceId,
        userId: widget.item!.userId,
        quantity: 0,
        sets: 0,
        weight: 0,
        isCompleted: false,
        orderNum: 0,

        /// handle order num
      );
      await ListItemsService.instance.create(item);
    }
  }

  void selectExercise(String ex) async {
    for (var element in exercises!) {
      if (element.name == ex) {
        setState(() {
          selectedExercise = element;
        });
      }
    }
  }

  void getExercise() {
    ExercisesService.instance
        .readExercise(widget.item!.exerciseId)
        .then((value) {
      setState(() {
        selectedExercise = value;
      });
    });
  }

  Future searchExercisesByName(String name) async {
    return await ExercisesService.instance
        .searchExercisesByName(name)
        .then((value) {
      setState(() {
        exercises = value;
      });
    }).then((value) => value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          //width full screen
          width: MediaQuery.of(context).size.width * 0.8,
          child: Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              return searchExercisesByName(textEditingValue.text).then((value) {
                return exercises!.map((e) => e.name);
              });
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) =>
                    TextField(
              controller: textEditingController,
              focusNode: focusNode,
              style: const TextStyle(fontSize: 18, color: Colors.white70),
              onSubmitted: (value) {
                onFieldSubmitted();
              },
              decoration: InputDecoration(
                prefix: TextButton(
                  onPressed: () {
                    onFieldSubmitted();
                  },
                  child: Text(selectedExerciseInput!),
                ),
                hintText: 'Search exercises',
                hintStyle: const TextStyle(fontSize: 18, color: Colors.white70),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    textEditingController.clear();
                  },
                ),
              ),
            ),
            optionsViewBuilder: (context, onSelected, options) {
              return Material(
                elevation: 4.0,
                color: Colors.blueGrey[800],
                child: SizedBox(
                  height: 50,
                  child: ListTileTheme(
                    dense: true,
                    selectedColor: Colors.white,
                    tileColor: Colors.blueGrey[800],
                    textColor: Colors.white70,
                    selectedTileColor: Colors.blue[800],
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            onSelected(option);
                          },
                          child: ListTile(
                            title: Text(
                              option,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            onSelected: (String selection) {
              selectExercise(selection);
            },
          ),
        ),
      ],
    );

    // if (selectedExercise != null)
    //   IconButton(
    //     icon: const Icon(Icons.add, color: Colors.white70),
    //     onPressed: () {
    //       createListItem();
    //     },
    //   ),
  }
}













// return DropdownSearch<String>(
//       popupProps: const PopupProps.menu(
//         showSelectedItems: true,
//         constraints: BoxConstraints(
//           maxHeight: 300,
//         ),
//       ),
//       items: exercises?.map((e) => e.name).toList() ?? ["No exercises found"],
//       dropdownDecoratorProps: const DropDownDecoratorProps(
//         dropdownSearchDecoration: InputDecoration(
//           labelText: "Menu mode",
//           hintText: "country in menu mode",
//         ),
//       ),
//       onChanged: (value) {
//         if (value != null && value.isNotEmpty) {
//           searchExercisesByName(value);
//         }
//       },
//       selectedItem: "No exercises found",
//     );