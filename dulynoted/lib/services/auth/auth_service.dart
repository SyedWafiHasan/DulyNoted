import 'package:dulynoted/services/auth/auth_provider.dart';
import 'package:dulynoted/services/auth/auth_user.dart';
import 'package:dulynoted/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider authProvider;
  const AuthService(this.authProvider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> initialize() => authProvider.initialize();

  @override
  Future<AuthUser> createUser({required String email, required String password})
    => authProvider.createUser(email: email, password: password);


  AuthUser? get currentUser => authProvider.currentUser;

  @override
  Future<AuthUser> logIn({required String email, required String password})
    => authProvider.logIn(email: email, password: password);

  @override
  Future<void> logOut() => authProvider.logOut();

  @override
  Future<void> sendEmailVerification() => authProvider.sendEmailVerification();
}