/// Model data untuk entitas Post.
///
/// Merepresentasikan satu post dari endpoint
/// `https://jsonplaceholder.typicode.com/posts`.
class Post {
  /// ID pengguna yang membuat post.
  final int userId;

  /// ID unik post.
  final int id;

  /// Judul post.
  final String title;

  /// Isi/body post.
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  /// Membuat instance [Post] dari JSON (Map).
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  /// Mengubah instance [Post] menjadi JSON (Map).
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'id': id, 'title': title, 'body': body};
  }
}
