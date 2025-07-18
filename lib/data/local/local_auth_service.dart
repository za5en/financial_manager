import 'dart:developer';

import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  static final auth = LocalAuthentication();

  static Future<bool> canAuthenticate() async {
    return await auth.canCheckBiometrics || await auth.isDeviceSupported();
  }

  static Future<bool> authenticate() async {
    try {
      if (!await canAuthenticate()) return false;

      return await auth.authenticate(
        options: const AuthenticationOptions(biometricOnly: true),
        localizedReason: 'Введите код для входа в приложение',
      );
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
