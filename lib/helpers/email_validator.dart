import 'package:email_validator/email_validator.dart';

bool emailValidator(String email) => EmailValidator.validate(email);
