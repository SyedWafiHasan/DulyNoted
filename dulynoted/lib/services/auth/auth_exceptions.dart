// Login Exceptions

class UserNotFoundAuthException implements Exception {}
class WrongPasswordAuthException implements Exception {}

// Registration exception

class WeakPasswordAuthException implements Exception {}
class EmailAlreadyInUseAuthException implements Exception {}
class InvalidEmailAuthException implements Exception {}

// Generic Exceptions

class GenericAuthException implements Exception {}
class UserNotLoggedInAuthException implements Exception {}