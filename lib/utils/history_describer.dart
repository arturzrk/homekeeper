class HistoryDescriber {
  static String describe(DateTime historyDate) {
    DateTime currentDate = DateTime.now();
    var difference = currentDate.difference(historyDate);
    if (difference < Duration(hours: 1)) {
      return "Less than 1 hour ago.";
    }
    if (difference < Duration(hours: 24)) {
      return "${difference.inHours} hours ago.";
    }
    if (difference < Duration(hours: 48)) {
      return "${difference.inDays} day ago.";
    }
    return "${difference.inDays} days ago.";
  }
}
