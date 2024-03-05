enum LoginFormType {
  username,
  password,
}

extension RawData on LoginFormType {
  String getTextFieldName() {
    switch (this) {
      case LoginFormType.username:
        return "Email Address";
      case LoginFormType.password:
        return "Password";
    }
  }

  String getHintTextFieldName() {
    switch (this) {
      case LoginFormType.username:
        return "Email Address";
      case LoginFormType.password:
        return "Password";
    }
  }
}

