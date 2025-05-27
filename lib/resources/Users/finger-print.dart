// import 'package:local_auth/local_auth.dart';
//
// Future<bool> authenticateWithBiometrics() async {
//   final LocalAuthentication auth = LocalAuthentication();
//
//   final bool canCheckBiometrics = await auth.canCheckBiometrics;
//   final bool isDeviceSupported = await auth.isDeviceSupported();
//
//   if (!canCheckBiometrics || !isDeviceSupported) return false;
//
//   try {
//     final bool didAuthenticate = await auth.authenticate(
//       localizedReason: 'Vui lòng xác thực vân tay để đăng nhập',
//       options: const AuthenticationOptions(
//         biometricOnly: true,
//         stickyAuth: true,
//       ),
//     );
//     return didAuthenticate;
//   } catch (e) {
//     print("❌ Lỗi xác thực vân tay: $e");
//     return false;
//   }
// }
