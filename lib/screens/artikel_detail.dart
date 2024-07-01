import 'package:flutter/material.dart';
import 'package:koimedic/screens/models/koi_data.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: SingleChildScrollView(
        // Memastikan konten dapat di-scroll
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, // Menjaga agar teks berada di sebelah kiri
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    article.imageUrl,
                    width: double.infinity,
                    height: 200, // Ukuran tinggi gambar yang tetap
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                article.title, // Menambahkan judul artikel
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                article.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              _buildAdditionalContent(), // Fungsi tambahan untuk konten ekstra
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalContent() {
    // Menambahkan elemen UI tambahan untuk memperkaya konten artikel
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Here you can add more information or additional content related to the article.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        // Tambahkan lebih banyak widget jika diperlukan
      ],
    );
  }
}
