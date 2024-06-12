/// Mixin of picking time without hours
mixin DateTimePickerMixin {
  String pickDateTime(String dateTimeString) {
    List<String> dateAndTime = dateTimeString.split(' ');
    String datePart = dateAndTime[0];

    List<String> dateComponents = datePart.split('-');
    String year = dateComponents[0];
    String month = dateComponents[1];
    String day = dateComponents[2];

    return '$day.$month.$year';
  }
}
