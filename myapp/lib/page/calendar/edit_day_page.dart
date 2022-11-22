// import 'package:flutter/material.dart';
// import '../../db/day/days_database.dart';
// import '../../model/day.dart';
// import '../widget/day/day_form_widget.dart';

// class AddEditDayPage extends StatefulWidget {
//   final Day? day;

//   const AddEditDayPage({
//     Key? key,
//     this.day,
//   }) : super(key: key);
//   @override
//   _AddEditDayPageState createState() => _AddEditDayPageState();
// }

// class _AddEditDayPageState extends State<AddEditDayPage> {
//   final _formKey = GlobalKey<FormState>();
//   late bool isImportant;
//   late int number;
//   late String title;
//   late String description;

//   @override
//   void initState() {
//     super.initState();

//     isImportant = widget.day?.isImportant ?? false;
//     number = widget.day?.number ?? 0;
//     title = widget.day?.title ?? '';
//     description = widget.day?.description ?? '';
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           actions: [buildButton()],
//         ),
//         body: Hero(
//           tag: 'hero${widget.day?.id}',
//           child: Form(
//             key: _formKey,
//             child: DayFormWidget(
//               isImportant: isImportant,
//               number: number,
//               title: title,
//               description: description,
//               onChangedImportant: (isImportant) =>
//                   setState(() => this.isImportant = isImportant),
//               onChangedNumber: (number) => setState(() => this.number = number),
//               onChangedTitle: (title) => setState(() => this.title = title),
//               onChangedDescription: (description) =>
//                   setState(() => this.description = description),
//             ),
//           ),
//         ),
//       );

//   Widget buildButton() {
//     final isFormValid = title.isNotEmpty && description.isNotEmpty;

//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           onPrimary: Colors.white,
//           primary: isFormValid ? null : Colors.grey.shade700,
//         ),
//         onPressed: addOrUpdateDay,
//         child: Text('Save'),
//       ),
//     );
//   }

//   void addOrUpdateDay() async {
//     final isValid = _formKey.currentState!.validate();

//     if (isValid) {
//       final isUpdating = widget.day != null;

//       if (isUpdating) {
//         await updateDay();
//       } else {
//         await addDay();
//       }

//       Navigator.of(context).pop();
//     }
//   }

//   Future updateDay() async {
//     final day = widget.day!.copy(
//       isImportant: isImportant,
//       number: number,
//       title: title,
//       description: description,
//     );

//     await DaysDatabase.instance.update(day);
//   }

//   Future addDay() async {
//     final day = Day(
//       title: title,
//       isImportant: true,
//       number: number,
//       description: description,
//       createdTime: DateTime.now(),
//     );

//     await DaysDatabase.instance.create(day);
//   }
// }
