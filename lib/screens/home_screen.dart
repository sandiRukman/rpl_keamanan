import 'package:flutter/material.dart';
import '../services/secure_storage_service.dart';
import 'user_list_screen.dart';
import 'post_list_screen.dart'; // 1. IMPORT HALAMAN LATIHAN 1

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _tokenController = TextEditingController();
  final SecureStorageService _storageService = SecureStorageService();
  String? _savedToken;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final token = await _storageService.getToken();
    setState(() {
      _savedToken = token;
    });
  }

  Future<void> _saveToken() async {
    if (_tokenController.text.isNotEmpty) {
      await _storageService.saveToken(_tokenController.text);
      _tokenController.clear();
      _loadToken();
    }
  }

  Future<void> _deleteToken() async {
    await _storageService.deleteToken();
    _loadToken();
  }

  @override
  Widget build(BuildContext context) {
    // 2. PERBAIKAN ERROR SUBSTRING (RangeError): Memastikan panjang token aman dipotong
    String displayToken = '';
    if (_savedToken != null && _savedToken!.isNotEmpty) {
      displayToken = _savedToken!.length > 10
          ? '${_savedToken!.substring(0, 10)}...'
          : _savedToken!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Secure Storage & HTTP'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- CARD 1: SECURE STORAGE ---
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.lock, color: Colors.deepPurple),
                        SizedBox(width: 8),
                        Text('Secure Storage',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Simpan token atau PIN di secure storage (terenkripsi AES).',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _tokenController,
                      decoration: const InputDecoration(
                        labelText: 'Token',
                        prefixIcon: Icon(Icons.key),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _saveToken,
                            icon: const Icon(Icons.save),
                            label: const Text('Simpan'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _deleteToken,
                            icon: const Icon(Icons.delete),
                            label: const Text('Hapus'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _savedToken != null
                            ? Colors.green.shade50
                            : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _savedToken != null
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _savedToken != null
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: _savedToken != null
                                ? Colors.green
                                : Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _savedToken != null
                                  ? 'Token tersimpan: $displayToken'
                                  : 'Belum ada token tersimpan',
                              style: TextStyle(
                                color: _savedToken != null
                                    ? Colors.green.shade900
                                    : Colors.red.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- CARD 2: HTTP REQUEST ---
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.cloud, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('HTTP Request',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Ambil data dari REST API (JSONPlaceholder) menggunakan GET request.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),

                    // TOMBOL DAFTAR PENGGUNA
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UserListScreen()),
                          );
                        },
                        icon: const Icon(Icons.list),
                        label: const Text('Lihat Daftar Pengguna'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // 3. TOMBOL BARU: DAFTAR POST (LATIHAN 1)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PostListScreen()),
                          );
                        },
                        icon: const Icon(Icons.article),
                        label: const Text('Lihat Daftar Post'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}