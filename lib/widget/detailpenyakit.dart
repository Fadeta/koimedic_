import 'package:flutter/material.dart';

class Detailpenyakit extends StatefulWidget {
  @override
  State<Detailpenyakit> createState() => _DetailpenyakitState();
}

class _DetailpenyakitState extends State<Detailpenyakit> {
  final List<Map<String, String>> diseases = [
    {
      'name': 'White Spot',
      'description':
          'White Spot, adalah penyakit parasit yang disebabkan oleh protozoa Ichthyophthirius multifiliis. Gejala utama adalah munculnya bintik-bintik putih kecil di seluruh tubuh ikan, termasuk sirip dan insang. Ikan yang terinfeksi sering kali menunjukkan perilaku menggosok-gosokkan tubuh mereka ke benda keras untuk mengurangi rasa gatal. Penyakit ini dapat menyebar dengan cepat dalam akuarium atau kolam yang padat dan memerlukan penanganan segera dengan obat antiparasit khusus.'
    },
    {
      'name': 'Black Spot',
      'description':
          'Black Spot, disebabkan oleh larva parasit trematoda (fluke). Gejalanya meliputi bintik-bintik hitam kecil di kulit ikan, yang merupakan respons inflamasi dari tubuh ikan terhadap parasit. Ikan yang terinfeksi mungkin menunjukkan perilaku stres dan menggosok-gosokkan tubuh mereka. Pengobatan biasanya melibatkan penggunaan obat antiparasit dan memperbaiki kondisi lingkungan untuk mencegah infeksi lebih lanjut.'
    },
    {
      'name': 'Dropsy',
      'description':
          'Dropsy adalah kondisi di mana ikan mengalami pembengkakan tubuh yang signifikan akibat retensi cairan. Penyebab utama bisa bervariasi, termasuk infeksi bakteri, gangguan fungsi ginjal, atau kondisi lingkungan yang buruk. Gejala utama termasuk perut buncit, sisik yang terlihat menonjol keluar (pinecone appearance), dan letargi. Pengobatan biasanya melibatkan antibiotik dan peningkatan kualitas air.'
    },
    {
      'name': 'Cloudy Eyes',
      'description':
          'Cloudy Eyes adalah kondisi di mana mata ikan menjadi keruh atau buram. Penyebabnya bisa beragam, termasuk infeksi bakteri atau jamur, cedera fisik, atau kualitas air yang buruk. Ikan dengan Cloudy Eyes mungkin mengalami kesulitan melihat dan bisa menunjukkan perilaku stres. Pengobatan melibatkan perbaikan kualitas air dan penggunaan obat antibakteri atau antijamur jika diperlukan.'
    },
    {
      'name': 'Fin/Tail Rot',
      'description':
          'Fin/Tail Rot adalah infeksi bakteri yang menyebabkan kerusakan pada sirip dan ekor ikan. Penyebab utamanya adalah bakteri seperti Aeromonas atau Pseudomonas yang biasanya menyerang ikan yang stres atau terluka. Gejala meliputi sirip yang terlihat compang-camping, berubah warna, dan bisa membusuk hingga ke pangkal. Pengobatan termasuk penggunaan antibiotik dan perbaikan kondisi air untuk mengurangi stres dan mencegah infeksi lebih lanjut.'
    },
    {
      'name': 'Kutu Jangkar (Lernaea)',
      'description':
          'Kutu Jangkar adalah parasit eksternal yang menyerang ikan dengan cara menempelkan diri pada kulit dan sirip. Parasit ini terlihat seperti benang tipis yang mencuat dari tubuh ikan. Gejala meliputi peradangan, luka, dan iritasi di sekitar area yang terinfeksi. Ikan yang terinfeksi mungkin sering menggosokkan tubuh mereka ke benda keras untuk meredakan gatal. Pengobatan melibatkan pengangkatan kutu secara manual dan penggunaan obat antiparasit untuk membunuh larva yang tersisa.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penyakit Ikan Koi'),
      ),
      body: ListView.builder(
        itemCount: diseases.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diseases[index]['name']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    diseases[index]['description']!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
