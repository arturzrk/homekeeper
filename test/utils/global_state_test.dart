import 'package:test/test.dart';
import 'package:homekeeper/utils/global_state.dart';

void main() {
  test('GivenEmptyGlobalState_When_GetAccountName_DefaultValueReturned', () {
    //given
    var sut = GlobalState();
    //when, then
    expect(sut.accountName, equals(GlobalState.DEFAULT_ACCOUNT_NAME));
  });

  test('GivenGlobalState_When_GetAccountName_CorrectValueReturned', () {
    var testAccountName = 'testaccont@someemail.com';
    var sut = GlobalState(accountName: testAccountName);
    expect(sut.accountName, equals(testAccountName));
  });

}