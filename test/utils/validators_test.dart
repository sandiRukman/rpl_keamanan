import 'package:flutter_test/flutter_test.dart';
// Sesuaikan nama package di bawah ini dengan nama package pada pubspec.yaml
// proyek Anda, misalnya: import 'package:rpl_keamanan/utils/validators.dart';
import 'package:rpl_keamanan/utils/validators.dart';

void main() {
  group('Validators.isValidEmail', () {
    test('email dengan format valid mengembalikan true', () {
      expect(Validators.isValidEmail('user@example.com'), true);
    });

    test('email tanpa karakter @ mengembalikan false', () {
      expect(Validators.isValidEmail('userexample.com'), false);
    });

    test('email tanpa domain setelah @ mengembalikan false', () {
      expect(Validators.isValidEmail('user@'), false);
    });

    test('email kosong mengembalikan false', () {
      expect(Validators.isValidEmail(''), false);
    });

    test('email dengan subdomain tetap valid', () {
      expect(Validators.isValidEmail('user@mail.example.com'), true);
    });
  });

  group('Validators.sanitize dengan input berbahaya', () {
    test('menghapus/mengenkode tag <script> (percobaan XSS)', () {
      const input = '<script>alert("xss")</script>';
      final result = Validators.sanitize(input);
      expect(result.contains('<script>'), false);
      expect(result.contains('&lt;script&gt;'), true);
    });

    test('mengenkode tanda kutip ganda dan tunggal', () {
      const input = 'He said "hello" and \'hi\'';
      final result = Validators.sanitize(input);
      expect(result.contains('"'), false);
      expect(result.contains("'"), false);
    });

    test('mengenkode percobaan SQL injection sederhana', () {
      const input = "' OR '1'='1";
      final result = Validators.sanitize(input);
      expect(result.contains("'"), false);
    });

    test('menghapus spasi di awal dan akhir (trim)', () {
      const input = '   hello world   ';
      expect(Validators.sanitize(input), 'hello world');
    });

    test('input kosong tetap mengembalikan string kosong', () {
      expect(Validators.sanitize(''), '');
    });
  });

  group('Validators.validateText dengan berbagai panjang', () {
    test('input null mengembalikan pesan error tidak boleh kosong', () {
      final result = Validators.validateText(null, fieldName: 'Nama');
      expect(result, 'Nama tidak boleh kosong');
    });

    test('input kosong (hanya spasi) mengembalikan pesan error', () {
      final result = Validators.validateText('   ', fieldName: 'Nama');
      expect(result, 'Nama tidak boleh kosong');
    });

    test('input lebih pendek dari minLength mengembalikan error', () {
      final result = Validators.validateText('ab', minLength: 3, maxLength: 10);
      expect(result, isNotNull);
    });

    test('input lebih panjang dari maxLength mengembalikan error', () {
      final longText = 'a' * 101;
      final result = Validators.validateText(longText, maxLength: 100);
      expect(result, isNotNull);
    });

    test('input dengan panjang pas di batas minLength valid', () {
      final result = Validators.validateText(
        'abc',
        minLength: 3,
        maxLength: 10,
      );
      expect(result, isNull);
    });

    test('input dengan panjang valid mengembalikan null', () {
      final result = Validators.validateText(
        'Halo dunia',
        minLength: 1,
        maxLength: 100,
      );
      expect(result, isNull);
    });
  });

  group('Validators.validatePhone (Latihan 3)', () {
    test('nomor 10 digit valid', () {
      expect(Validators.validatePhone('0812345678'), isNull);
    });

    test('nomor 13 digit valid', () {
      expect(Validators.validatePhone('0812345678901'), isNull);
    });

    test('nomor kurang dari 10 digit tidak valid', () {
      expect(Validators.validatePhone('12345'), isNotNull);
    });

    test('nomor lebih dari 13 digit tidak valid', () {
      expect(Validators.validatePhone('081234567890123'), isNotNull);
    });

    test('nomor mengandung huruf tidak valid', () {
      expect(Validators.validatePhone('081234abcd'), isNotNull);
    });
  });

  group('Validators.validateUrl (Latihan 3)', () {
    test('URL dengan https:// valid', () {
      expect(Validators.validateUrl('https://example.com'), isNull);
    });

    test('URL dengan http:// valid', () {
      expect(Validators.validateUrl('http://example.com'), isNull);
    });

    test('URL tanpa skema tidak valid', () {
      expect(Validators.validateUrl('example.com'), isNotNull);
    });

    test('URL kosong tidak valid', () {
      expect(Validators.validateUrl(''), isNotNull);
    });
  });

  group('Validators.validatePassword (Latihan 3)', () {
    test('password memenuhi semua syarat valid', () {
      expect(Validators.validatePassword('Passw0rd!'), isNull);
    });

    test('password kurang dari 8 karakter tidak valid', () {
      expect(Validators.validatePassword('P1!aaa'), isNotNull);
    });

    test('password tanpa huruf kapital tidak valid', () {
      expect(Validators.validatePassword('passw0rd!'), isNotNull);
    });

    test('password tanpa angka tidak valid', () {
      expect(Validators.validatePassword('Password!'), isNotNull);
    });

    test('password tanpa simbol tidak valid', () {
      expect(Validators.validatePassword('Passw0rd'), isNotNull);
    });
  });
}
