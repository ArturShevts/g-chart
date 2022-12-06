import 'dart:convert';

import 'package:flutter/services.dart';

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

            textArr.length > 1 ? textArr.removeLast() : null;
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
