enum AuthenticationOTPType {
  forgotPassword,
  register,
  registerSSO;

  String get action {
    switch(this) {
      case AuthenticationOTPType.forgotPassword:
        return 'recovery';
      case AuthenticationOTPType.register:
        return 'register';
      case AuthenticationOTPType.registerSSO:
        return 'register';
    }
  }
}

extension RawAuthenType on String {
  AuthenticationOTPType toOTPType() {
    switch(this) {
      case 'forgotPassword':
        return  AuthenticationOTPType.forgotPassword;
      case 'register':
        return AuthenticationOTPType.register;
      default:
        return  AuthenticationOTPType.registerSSO;
    }
  }
}

extension RawData on AuthenticationOTPType {
  String getTitleText() {
    switch (this) {
      case AuthenticationOTPType.forgotPassword:
        return "ลืมรหัสผ่าน";
      case AuthenticationOTPType.register:
      case AuthenticationOTPType.registerSSO:

        return "สมัครสมาชิก";
    }
  }

  String getTitlePassWordFormText() {
    switch (this) {
      case AuthenticationOTPType.forgotPassword:
        return "ตั้งรหัสผ่านใหม่";
      case AuthenticationOTPType.register:
        return "ตั้งรหัสผ่าน";
      default:
        return "";
    }
  }

  String getPassWordFieldText() {
    switch (this) {
      case AuthenticationOTPType.forgotPassword:
        return "รหัสผ่านใหม่";
      case AuthenticationOTPType.register:
        return "รหัสผ่าน";
      default:
        return "";
    }
  }

  String getPassWordFieldHintText() {
    switch (this) {
      case AuthenticationOTPType.forgotPassword:
        return "กรอกรหัสผ่านใหม่";
      case AuthenticationOTPType.register:
        return "กรอกรหัสผ่าน";
      default:
        return "";
    }
  }

  String getConfirmPassWordFieldText() {
    switch (this) {
      case AuthenticationOTPType.forgotPassword:
        return "ยืนยันรหัสผ่านใหม่";
      case AuthenticationOTPType.register:
        return "ยืนยันรหัสผ่าน";
      default:
        return "";
    }
  }

  String getConfirmPassWordFieldHintText() {
    switch (this) {
      case AuthenticationOTPType.forgotPassword:
        return "ยืนยันรหัสผ่านใหม่";
      case AuthenticationOTPType.register:
        return "ยืนยันรหัสผ่าน";
      default:
        return "";
    }
  }

  String getStringPathParams() {
    switch (this) {
      case AuthenticationOTPType.forgotPassword:
        return "forgotPassword";
      case AuthenticationOTPType.register:
      case AuthenticationOTPType.registerSSO:

        return "register";

    }
  }

  String getSuccessTitle() {
    switch (this) {
      case AuthenticationOTPType.forgotPassword:
        return "ตั้งรหัสผ่านใหม่สำเร็จ";
      case AuthenticationOTPType.register:
        return "สมัครสมาชิกสำเร็จ";
      default:
        return "";
    }
  }

  List<String> getNodeTitleList() {
    switch (this) {
      case AuthenticationOTPType.forgotPassword:
        return [
          "กรอกรหัสผ่านใหม่",
          "ยืนยันรหัสผ่านใหม่",
        ];
      case AuthenticationOTPType.register:
        return [
          "กรอกรหัสผ่าน",
          "ยืนยันรหัสผ่าน",
        ];
      default:
        return ["",""];
    }
  }

  String getButtonFormText() {
    switch (this) {
      case AuthenticationOTPType.forgotPassword:
        return "ยืนยันรหัสผ่านใหม่";
      case AuthenticationOTPType.register:
        return "ยืนยัน";
      default:
        return "";
    }
  }
}

extension GetAuthenticationOtpType on String {
  AuthenticationOTPType getAuthenticationOtpType() {
    switch (this) {
      case "forgotPassword":
        return AuthenticationOTPType.forgotPassword;
      case "register":
        return AuthenticationOTPType.register;
      default:
        throw UnimplementedError();
    }
  }
}