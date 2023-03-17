// month input formatter

import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String inputData = newValue.text;
    StringBuffer stringBuffer = StringBuffer();

    // loop through the input data and add the characters to the string buffer,
    // to format the credit card number to have a space after every 4 characters
    for (int i = 0; i < inputData.length; i++) {
      if (i % 2 == 0 && i != 0 && i < 6) {
        stringBuffer.write('/');
      }
      stringBuffer.write(inputData[i]);
    }

    return newValue.copyWith(
      text: stringBuffer.toString(),
      selection: TextSelection.collapsed(offset: stringBuffer.toString().length),
    );
  }
}

class WeightInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String inputData = newValue.text;
    StringBuffer stringBuffer = StringBuffer();

    // loop through the input data and add the characters to the string buffer,
    // to format the credit card number to have a space after every 4 characters
    for (int i = 0; i < inputData.length; i++) {
      if (i % 2 == 0 && i != 0) {
        stringBuffer.write('.');
      }
      stringBuffer.write(inputData[i]);
    }

    return newValue.copyWith(
      text: stringBuffer.toString(),
      selection: TextSelection.collapsed(offset: stringBuffer.toString().length),
    );
  }
}
