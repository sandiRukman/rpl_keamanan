import '../repositories/post_repository.dart';
import '../repositories/post_repository_impl.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import '../services/api_service.dart';

/// Menyediakan instance dari [ApiService], [UserRepository], dan
/// [PostRepository] secara terpusat.
///
/// Menggunakan singleton pattern sehingga hanya ada satu instance
/// [ApiService] yang dipakai bersama oleh semua repository
/// (Latihan 2 - Petunjuk b).
class DependencyInjector {
  static final DependencyInjector _instance = DependencyInjector._internal();

  /// Mengembalikan instance tunggal [DependencyInjector].
  factory DependencyInjector() => _instance;

  /// Instance tunggal [ApiService] yang dipakai bersama oleh repository.
  late ApiService apiService;

  /// Instance [UserRepository] yang dibangun di atas [apiService] yang sama.
  late UserRepository userRepository;

  /// Instance [PostRepository] yang dibangun di atas [apiService] yang sama.
  late PostRepository postRepository;

  DependencyInjector._internal() {
    apiService = ApiService();
    userRepository = UserRepositoryImpl(apiService: apiService);
    postRepository = PostRepositoryImpl(apiService: apiService);
  }

  /// Berguna untuk unit test: mengganti instance dengan dependency palsu
  /// (mock) tanpa perlu membuat instance baru dari awal.
  void overrideForTesting({
    ApiService? apiService,
    UserRepository? userRepository,
    PostRepository? postRepository,
  }) {
    if (apiService != null) this.apiService = apiService;
    if (userRepository != null) this.userRepository = userRepository;
    if (postRepository != null) this.postRepository = postRepository;
  }
}
