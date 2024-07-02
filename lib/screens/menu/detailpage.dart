import 'package:flutter/material.dart';

class Detailpage extends StatefulWidget {
  const Detailpage({super.key});

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Koi Medic - Diagnosa Penyakit Ikan Koi'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tentang Aplikasi Koi Medic',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Aplikasi Koi Medic dirancang untuk membantu para pecinta ikan koi dalam mendiagnosa penyakit yang mungkin menyerang ikan mereka. Dengan menggunakan aplikasi ini, pengguna dapat dengan mudah mengidentifikasi penyakit berdasarkan dua metode diagnostik: Diagnosa Berdasarkan Gejala dan Diagnosa Berdasarkan Penyakit.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                '1. Diagnosa Berdasarkan Gejala',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Metode ini memungkinkan pengguna untuk mengidentifikasi penyakit ikan koi dengan cara mengamati gejala-gejala yang ditunjukkan oleh ikan. Berikut langkah-langkahnya:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '• Pengguna harus terlebih dahulu melakukan observasi terhadap ikan koi dan mencatat gejala-gejala yang terlihat.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Setelah itu, pengguna menginputkan gejala-gejala tersebut ke dalam aplikasi.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Aplikasi kemudian akan menganalisis data gejala yang diinputkan dan memberikan hasil diagnosa yang paling mungkin berdasarkan database penyakit yang ada.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                '2. Diagnosa Berdasarkan Penyakit',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Metode ini membantu pengguna untuk memahami gejala-gejala yang terkait dengan penyakit tertentu. Langkah-langkahnya adalah sebagai berikut:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '• Pengguna memilih penyakit yang ingin mereka ketahui lebih lanjut dari daftar penyakit yang tersedia di aplikasi.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Aplikasi kemudian akan menampilkan gejala-gejala umum yang berhubungan dengan penyakit tersebut.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Pengguna kemudian membandingkan gejala-gejala yang ditampilkan dengan gejala yang diamati pada ikan koi mereka.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Setelah mencocokkan gejala-gejala, pengguna menginputkan gejala yang sesuai ke dalam aplikasi, yang kemudian akan memberikan hasil diagnosa dan tingkat akurasi dari penyakit yang dipilih.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                'Aplikasi Koi Medic ini sangat berguna untuk membantu menjaga kesehatan ikan koi Anda dengan cepat dan efektif. Dengan menggunakan metode diagnostik yang komprehensif, aplikasi ini memastikan bahwa pengguna mendapatkan informasi yang akurat dan bermanfaat dalam merawat ikan koi mereka.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
