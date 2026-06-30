extension PhoneFormatting on String {
  String get formattedPhone {
    String digits = replaceAll(RegExp(r'\D'), '');

    if (digits.startsWith('8')) {
      digits = '7${digits.substring(1)}';
    }

    if (digits.length != 11 || !digits.startsWith('7')) {
      return this;
    }

    return '+7 (${digits.substring(1, 4)}) ${digits.substring(4, 7)}-${digits.substring(7, 9)}-${digits.substring(9, 11)}';
  }
}
