class TextUtils {
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a birth date';
    }
    int year;
    int month;
    int day;

    if (value.contains(RegExp(r'(/)'))) {
      var split = value.split((RegExp(r'(/)')));
      // The value before the slash is the month while the value after the slash is the year
      if (split.length < 3) {
        return 'The date must be in the format dd/mm/yyyy';
      }
      day = int.parse(split[0]);
      month = int.parse(split[1]);
      year = int.parse(split[2]);
    } else {
      // Only the day was entered
      day = int.parse(value.substring(0, (value.length)));
      month = -1;
      year = -1;
    }

    // check if day is valid
    if (day < 1 || day > 31) {
      return 'The day must be between 1 and 31';
    }

    if (month < 1 || month > 12) {
      return 'The month must be between 1 and 12';
    }

    var fourDigitYear = convertYearTo4Digits(year);
    if (fourDigitYear > DateTime.now().year) {
      return 'The date cannot be in the future!';
    } else if (fourDigitYear < 2000) {
      return 'The date cannot be before 2000';
    }

    return null;
  }

  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }
}
