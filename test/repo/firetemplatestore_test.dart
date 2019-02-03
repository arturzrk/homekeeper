import 'package:flutter_test/flutter_test.dart';
import 'package:homekeeper/repo/template/firetemplatestore.dart';

void main() {
  group('firestore_tests', () {
    final testAccountName = 'test@account.com';

    test('NullAccountNameThrows', () {

      //Assert
      expect(() => FireTemplateStore(accountName: null), throwsAssertionError);
    });

    test('ProperCollectionNameReturned', () {
      //Arrange
      var sut = FireTemplateStore(accountName: testAccountName);
      //when
      var collectionPath = sut.getCollectionPath();
      expect(collectionPath, equals('users/$testAccountName/template'));
    });
  });
}
