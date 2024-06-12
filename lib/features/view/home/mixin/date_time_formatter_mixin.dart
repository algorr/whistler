mixin DateTimeFormatterMixin {
  String formatDateTimeString(String dateTimeString) {
    List<String> dateAndTime = dateTimeString.split(' ');
    String datePart = dateAndTime[0];
    String timePart = dateAndTime[1];

    List<String> dateComponents = datePart.split('-');
    String year = dateComponents[0];
    String month = dateComponents[1];
    String day = dateComponents[2];

    List<String> timeComponents = timePart.split(':');
    String hour = timeComponents[0];
    String minute = timeComponents[1];

    return '$day.$month.$year $hour:$minute';
  }
}
