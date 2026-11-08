import '../models/post.dart';

/// Abstraksi repository untuk mengelola data Post.
///
/// Interface ini mendefinisikan kontrak untuk operasi data Post.
/// Implementasi konkretnya ada di [PostRepositoryImpl].
/// Pola ini sengaja dibuat sama seperti [UserRepository] agar konsisten.
abstract class PostRepository {
  /// Mengambil daftar semua post.
  ///
  /// Mengembalikan [List<Post>] jika berhasil.
  /// Melempar [Exception] jika terjadi error.
  Future<List<Post>> getPosts();

  /// Mengambil post berdasarkan [id].
  ///
  /// Parameter [id] harus berupa integer positif.
  /// Mengembalikan [Post] jika ditemukan.
  Future<Post> getPostById(int id);
}
