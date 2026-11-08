import 'package:flutter/foundation.dart';

/// Utilitas logging terstruktur dengan level: debug, info, warning, error.
///
/// Log hanya dicetak ketika aplikasi berjalan di mode debug ([kDebugMode]),
/// sehingga tidak membocorkan informasi apa pun saat aplikasi dirilis
/// (Latihan 4 - Petunjuk a).
///
/// PENTING: Logger ini tidak pernah digunakan untuk mencatat data sensitif
/// seperti API key, token autentikasi, atau password. Pemanggil bertanggung
/// jawab untuk tidak menyertakan data tersebut dalam [message].
class Logger {
  Logger._();

  /// Mencatat pesan level debug. Gunakan untuk informasi rinci saat
  /// pengembangan, misalnya isi variabel atau alur eksekusi.
  static void debug(String message, {String tag = 'DEBUG'}) {
    _log('DEBUG', tag, message);
  }

  /// Mencatat pesan level info. Gunakan untuk kejadian normal,
  /// misalnya "Data berhasil dimuat".
  static void info(String message, {String tag = 'INFO'}) {
    _log('INFO', tag, message);
  }

  /// Mencatat pesan level warning. Gunakan untuk kondisi yang tidak normal
  /// tetapi belum menyebabkan kegagalan, misalnya "Konfigurasi tidak lengkap".
  static void warning(String message, {String tag = 'WARNING'}) {
    _log('WARNING', tag, message);
  }

  /// Mencatat pesan level error. Gunakan untuk kegagalan yang perlu
  /// diperhatikan, misalnya exception yang tertangkap.
  ///
  /// Parameter [error] dan [stackTrace] bersifat opsional dan hanya
  /// dicetak di mode debug.
  static void error(
    String message, {
    String tag = 'ERROR',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log('ERROR', tag, message);
    if (kDebugMode) {
      if (error != null) print('  Penyebab: $error');
      if (stackTrace != null) print('  Stack trace: $stackTrace');
    }
  }

  /// Method internal yang benar-benar mencetak log.
  ///
  /// Mengembalikan langsung tanpa mencetak apa pun jika tidak dalam
  /// mode debug, sehingga aman digunakan di build release.
  static void _log(String level, String tag, String message) {
    if (!kDebugMode) return;
    final timestamp = DateTime.now().toIso8601String();
    print('[$timestamp] [$level] [$tag] $message');
  }
}
