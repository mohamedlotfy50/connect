import 'package:connect/domain/auth/email.dart';
import 'package:connect/domain/auth/password.dart';
import 'package:connect/infrastructure/auth/errors.dart';
import 'package:dartz/dartz.dart';

import '../../domain/shared/user.dart';

class Authentication {
  Future<Either<AuthenticationError, User>> login(
      Email emai, Password password) async {
    return left(AuthenticationError.invalid);
  }

  Future<Either<AuthenticationError, User>> register(
      Email emai, Password password) async {
    return left(AuthenticationError.invalid);
  }
}
