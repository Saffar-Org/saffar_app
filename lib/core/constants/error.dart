class Err {
  static const _Code code = _Code();
  static const _Message message = _Message();
}

class _Code {
  const _Code();

  final String userNotLoggedIn = 'USER_NOT_LOGGED_IN';
}

class _Message {
  const _Message();

  final String userNotLoggedIn = 'User not logged in';
}