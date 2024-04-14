import 'package:firebase_auth/firebase_auth.dart';
import 'package:homelinker/data/secure_storage/secure_storage_keys.dart';
import 'package:homelinker/data/secure_storage/secure_storage_source.dart';
import 'package:homelinker/models/enums/account_type.dart';
import 'package:homelinker/services/account/auth_exceptions.dart';
import 'package:homelinker/services/user/user_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class AccountService {
  AccountService(this._secureStorage, this._userService);

  final SecureStorageSource _secureStorage;
  final UserService _userService;

  Future<bool> isUserLoggedIn() async =>
      (await _secureStorage.get(SecureStorageKeys.loginToken))?.isNotEmpty ??
      false;

  Future<void> login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password);
    } on FirebaseAuthException catch (ex) {
      switch (ex.code) {
        case 'invalid-email':
          await logout();
          throw InvalidEmailException();
        case 'user-not-found':
          await logout();
          throw UserNotFoundException();
        case 'wrong-password':
          await logout();
          throw WrongPasswordException();
        case 'user-disabled':
          await logout();
          throw InvalidCredentialsException();
        case 'too-many-requests':
          await logout();
          throw TooManyRequestsException();
        default:
          await logout();
          throw Exception();
      }
    } on Exception {
      await logout();
      throw LoginException();
    }

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      await logout();
      throw LoginException();
    }

    if (currentUser.emailVerified) {
      final token = await currentUser.getIdToken();
      if (token == null) {
        await logout();
        throw LoginException();
      }
      await _secureStorage.set(SecureStorageKeys.loginToken, token);
      await _secureStorage.set(SecureStorageKeys.userEmail, email.trim());
    } else {
      await logout();

      throw EmailNotVerifiedException();
    }
  }

  Future<void> createAccount({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required AccountType accountType,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password);
      await userCredential.user!.sendEmailVerification();
      await _userService.createUser(
        email: email.trim(),
        accountType: accountType,
        name: name,
        phoneNumber: phoneNumber,
      );

      await _secureStorage.delete(SecureStorageKeys.loginToken);
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (ex) {
      switch (ex.code) {
        case 'email-already-in-use':
          throw EmailAlreadyUsedException();
        case 'too-many-requests':
          throw TooManyRequestsException();
        default:
          throw Exception();
      }
    } on Exception {
      throw LoginException();
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (ex) {
      switch (ex.code) {
        case 'user-not-found':
          throw UserNotFoundException();
        case 'too-many-requests':
          throw TooManyRequestsException();
        default:
          throw Exception();
      }
    } on Exception {
      throw LoginException();
    }
  }

  Future<void> updatePassword({required String password}) async {
    await FirebaseAuth.instance.currentUser!.updatePassword(password);
  }

  Future<void> refreshLogin(
      {required String email, required String password}) async {
    final credential =
        EmailAuthProvider.credential(email: email, password: password);

    await FirebaseAuth.instance.currentUser
        ?.reauthenticateWithCredential(credential);
  }

  Future<void> deleteAccount() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }

  Future<void> logout() async {
    await _secureStorage.delete(SecureStorageKeys.loginToken);

    await FirebaseAuth.instance.signOut();
  }
}
