class GlobalState {

  static const DEFAULT_ACCOUNT_NAME = 'development@zayaprojekt.com';

  String _accountName;

  GlobalState( {String accountName} ) {
    _accountName = accountName;
  }

  String get accountName => _accountName == null ? DEFAULT_ACCOUNT_NAME : _accountName;

  set accountName(String accountName) {
    _accountName = accountName;
  }
}