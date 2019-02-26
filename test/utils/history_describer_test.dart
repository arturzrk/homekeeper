import 'package:test/test.dart';
import 'package:homekeeper/utils/history_describer.dart';

void main() {
  group("Describe method tests", () {
    test(
        'Given_DateLessThan1HourInThePast_When_Describe_LessThanAnHourReturned',
        () {
      //Arrange
      DateTime nowDate = DateTime.now();
      DateTime historyDate = nowDate.subtract(Duration(minutes: 59));
      //Act
      var result = HistoryDescriber.describe(historyDate);
      //Assert
      expect(result, equals('Less than 1 hour ago.'));
    });

    test('Given_Date6HoursInThePast_When_Describe_NumberOfHoursReturned', () {
      //Arrange
      DateTime nowDate = DateTime.now();
      DateTime historyDate = nowDate.subtract(Duration(hours: 6));
      //Act
      var result = HistoryDescriber.describe(historyDate);
      //Assert
      expect(result, equals('6 hours ago.'));
    });

    test('Given_Date11HoursInThePast_When_Describe_NumberOfHoursReturned', () {
      //Arrange
      DateTime nowDate = DateTime.now();
      DateTime historyDate = nowDate.subtract(Duration(hours: 11));
      //Act
      var result = HistoryDescriber.describe(historyDate);
      //Assert
      expect(result, equals('11 hours ago.'));
    });

    test(
        'Given_MoreThan24LessThan48HoursInThePast_When_Describe_NumberOfDaysReturned',
        () {
      //Arrange
      DateTime nowDate = DateTime.now();
      DateTime historyDate = nowDate.subtract(Duration(hours: 25));
      //Act
      var result = HistoryDescriber.describe(historyDate);
      //Assert
      expect(result, equals('1 day ago.'));
    });

    test('Given_MoreThan4848HoursInThePast_When_Describe_NumberOfDaysReturned',
        () {
      //Arrange
      DateTime nowDate = DateTime.now();
      DateTime historyDate = nowDate.subtract(Duration(days: 15));
      //Act
      var result = HistoryDescriber.describe(historyDate);
      //Assert
      expect(result, equals('15 days ago.'));
    });
  });
}
