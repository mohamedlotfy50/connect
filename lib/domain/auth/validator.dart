import 'package:connect/domain/auth/errors.dart';
import 'package:dartz/dartz.dart';

class Validator {
  Either<EmailError, String> validateEmail(String value) {
    return left(EmailError.invaid);
  }

  Either<PasswordError, String> validatePassword(String value) {
    return left(PasswordError.invaid);
  }
}
