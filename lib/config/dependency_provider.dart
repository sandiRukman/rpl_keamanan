import 'package:flutter/widgets.dart';
import 'dependency_injector.dart';

/// Menyediakan [DependencyInjector] ke seluruh widget tree menggunakan
/// [InheritedWidget], sehingga widget turunan dapat mengakses repository
/// tanpa perlu meneruskannya lewat constructor satu per satu.
class DependencyProvider extends InheritedWidget {
  /// Instance [DependencyInjector] yang dibagikan ke widget tree.
  final DependencyInjector injector;

  const DependencyProvider({
    super.key,
    required this.injector,
    required super.child,
  });

  /// Mengambil [DependencyInjector] terdekat dari [context].
  ///
  /// Gunakan di widget mana pun di bawah [DependencyProvider], contoh:
  /// `DependencyProvider.of(context).userRepository`.
  static DependencyInjector of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<DependencyProvider>();
    assert(
      provider != null,
      'DependencyProvider tidak ditemukan di widget tree. '
      'Pastikan widget ini dibungkus oleh DependencyProvider.',
    );
    return provider!.injector;
  }

  @override
  bool updateShouldNotify(DependencyProvider oldWidget) {
    return injector != oldWidget.injector;
  }
}
