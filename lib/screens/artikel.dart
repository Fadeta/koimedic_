import 'package:get/get.dart';
import 'package:koimedic/screens/models/koi_data.dart';

class ArticleController extends GetxController {
  var articles = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  void fetchArticles() {
    var articleList = [
      Article(
        title: 'Ternyata Begini, Cara Karantina Ikan Koi!',
        imageUrl:
            'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//catalog-image/98/MTA-150167239/no-brand_no-brand_full01.jpg',
        description: '''
Karantina ikan koi adalah langkah penting untuk memastikan kesehatan dan keamanan ikan, baik saat baru dibeli maupun ketika ada tanda-tanda penyakit. Berikut adalah langkah-langkah karantina yang baik dan benar untuk ikan koi:

### Persiapan Karantina

1. **Siapkan Kolam atau Tangki Karantina:**
  - Gunakan tangki atau kolam terpisah dengan kapasitas yang memadai untuk ikan koi yang akan dikarantina.
  - Pastikan tangki dilengkapi dengan filter dan aerasi yang baik untuk menjaga kualitas air.

2. **Bersihkan dan Sterilkan:**
  - Bersihkan dan sterilkan tangki atau kolam dengan larutan pemutih atau antiseptik untuk membunuh bakteri dan parasit yang mungkin ada.

3. **Isi Air:**
  - Isi tangki dengan air bersih yang telah diendapkan atau diberi dechlorinator untuk menghilangkan klorin.
  - Usahakan suhu air dalam tangki karantina mirip dengan suhu kolam utama untuk mengurangi stres pada ikan.

4. **Tambahkan Garam:**
  - Tambahkan garam non-yodium (seperti garam kolam atau garam laut) ke dalam air dengan dosis 0,3% (3 gram per liter) untuk membantu mengurangi stres dan menekan pertumbuhan bakteri dan parasit.

### Proses Karantina

1. **Akklimatisasi:**
  - Tempatkan ikan koi dalam kantong plastik berisi air dari tangki asal.
  - Letakkan kantong tersebut di dalam tangki karantina selama sekitar 20-30 menit untuk menyeimbangkan suhu.
  - Tambahkan sedikit demi sedikit air dari tangki karantina ke dalam kantong plastik selama 15-20 menit sebelum melepaskan ikan ke dalam tangki karantina.

2. **Observasi:**
  - Amati ikan koi untuk tanda-tanda penyakit atau perilaku aneh seperti menggosok-gosokkan tubuh, berenang dengan cara yang tidak biasa, atau munculnya bintik-bintik putih.
  - Periksa kondisi kulit, sirip, dan insang ikan secara berkala.

3. **Pemberian Makanan:**
  - Berikan makanan berkualitas dalam jumlah yang sedikit dan pantau respon makan ikan.
  - Hindari memberi makan berlebihan yang dapat mengotori air.

4. **Pengobatan:**
  - Jika ada tanda-tanda penyakit, konsultasikan dengan ahli ikan atau gunakan obat yang tepat sesuai diagnosis penyakit.
  - Umumnya, obat untuk penyakit ikan koi meliputi antibiotik, antiparasit, atau garam untuk penyakit ringan.

### Pemeliharaan Selama Karantina

1. **Ganti Air:**
  - Ganti sebagian air (sekitar 20-30%) setiap 2-3 hari untuk menjaga kualitas air.
  - Selalu tambahkan dechlorinator dan garam setelah penggantian air.

2. **Pantau Kualitas Air:**
  - Periksa parameter air seperti pH, amonia, nitrit, dan nitrat secara teratur.
  - Pastikan parameter air berada dalam kisaran yang aman untuk koi (pH 6,5-8,5, amonia 0 ppm, nitrit 0 ppm, nitrat < 40 ppm).

3. **Durasi Karantina:**
  - Karantina biasanya berlangsung selama 2-4 minggu, tergantung pada kesehatan ikan dan ada tidaknya tanda-tanda penyakit.

4. **Siapkan Ikan untuk Perpindahan:**
  - Sebelum memindahkan ikan ke kolam utama, lakukan akklimatisasi seperti yang dilakukan pada saat awal karantina.

### Kesimpulan

Karantina ikan koi adalah langkah penting untuk mencegah penyebaran penyakit ke kolam utama dan memastikan kesehatan ikan. Proses ini memerlukan perhatian terhadap detail dan komitmen untuk pemeliharaan rutin. Dengan mengikuti langkah-langkah di atas, Anda dapat membantu ikan koi Anda tetap sehat dan kuat.
        ''',
      ),
      Article(
        title: 'Cara Mengatur Air dan Filter Kolam',
        imageUrl:
            'https://i.pinimg.com/736x/d6/cb/e2/d6cbe29267e01729467ff9c66cab42c1.jpg',
        description: '''
Kolam semen merupakan pilihan populer untuk memelihara ikan koi karena tahan lama dan dapat disesuaikan dengan berbagai ukuran. Namun, menjaga kualitas air di kolam semen membutuhkan perhatian khusus, terutama dalam hal pH dan sistem filtrasi. Berikut adalah panduan lengkap tentang cara mengelola air dalam kolam semen dan sistem filtrasi yang efektif.

### Persiapan Kolam Semen

1. **Proses Curing atau Penyembuhan Semen:**
  - Kolam semen yang baru dibangun perlu menjalani proses curing untuk mengurangi alkalinitas yang berlebihan.
  - Isi kolam dengan air dan biarkan selama 2-4 minggu, kemudian kuras dan ulangi proses ini beberapa kali untuk menghilangkan residu kimia dari semen.
  - Tambahkan dechlorinator atau zat netralisasi lain pada air saat proses curing.

2. **Pengujian pH:**
  - Setelah proses curing, uji pH air dalam kolam. Idealnya, pH harus berada di antara 7,0 dan 8,5.
  - Gunakan pH adjuster jika perlu untuk menstabilkan pH pada kisaran yang aman untuk ikan koi.

### Pengelolaan Kualitas Air

1. **Pengisian Awal Kolam:**
  - Isi kolam dengan air bersih yang telah diendapkan atau menggunakan dechlorinator untuk menghilangkan klorin.
  - Periksa dan sesuaikan pH air sebelum memasukkan ikan.

2. **Pengaturan Parameter Air:**
  - Pemantauan parameter air seperti pH, amonia, nitrit, dan nitrat secara teratur sangat penting.
  - pH kolam harus dipertahankan antara 7,0 dan 8,5, amonia dan nitrit harus berada di level 0 ppm, dan nitrat harus di bawah 40 ppm.

3. **Penggantian Air:**
  - Lakukan penggantian air secara berkala sekitar 10-20% setiap minggu untuk menjaga kualitas air.
  - Saat mengganti air, tambahkan dechlorinator dan sesuaikan pH air jika diperlukan.

4. **Penggunaan Bahan Kimia:**
  - Hindari penggunaan bahan kimia yang tidak diperlukan yang dapat merusak ekosistem kolam.
  - Jika diperlukan, gunakan bahan kimia yang ramah lingkungan dan sesuai dengan kebutuhan kolam Anda.

### Sistem Filtrasi untuk Kolam Semen

1. **Filter Mekanik:**
  - Filter mekanik bertugas untuk menyaring partikel-partikel besar seperti sisa makanan dan kotoran ikan dari air.
  - Pilih filter mekanik yang sesuai dengan ukuran kolam Anda dan pastikan untuk membersihkannya secara berkala.

2. **Filter Biologis:**
  - Filter biologis berfungsi untuk menguraikan zat-zat berbahaya seperti amonia dan nitrit menjadi nitrat yang kurang berbahaya.
  - Media filtrasi biologis, seperti bio-balls atau keramik, menyediakan permukaan bagi bakteri baik untuk berkembang.

3. **Filter Kimia:**
  - Filter kimia digunakan untuk menghilangkan zat-zat kimia tertentu dari air, seperti klorin atau logam berat.
  - Gunakan media seperti karbon aktif jika diperlukan untuk menyerap zat-zat kimia berbahaya.

4. **Sistem Filtrasi Kombinasi:**
  - Kombinasikan filter mekanik, biologis, dan kimia untuk hasil yang optimal.
  - Pastikan sistem filtrasi Anda memiliki kapasitas yang cukup untuk volume air di kolam dan jumlah ikan yang dipelihara.

### Pemeliharaan Sistem Filtrasi

1. **Pembersihan Filter:**
  - Bersihkan filter mekanik secara berkala untuk mencegah penyumbatan dan memastikan aliran air yang baik.
  - Jangan membersihkan filter biologis dengan air yang mengandung klorin, karena ini dapat membunuh bakteri baik. Gunakan air dari kolam saat membersihkan media biologis.

2. **Pemeriksaan Rutin:**
  - Periksa sistem filtrasi secara berkala untuk memastikan semuanya berjalan dengan baik.
  - Gantilah media filtrasi yang sudah jenuh atau tidak lagi efektif.

3. **Pengaturan Aliran Air:**
  - Pastikan aliran air dalam sistem filtrasi memadai dan tidak terlalu kuat atau terlalu lemah.
  - Sesuaikan aliran air agar sesuai dengan kebutuhan kolam dan ikan Anda.

### Pengelolaan Alga

1. **Pengendalian Pertumbuhan Alga:**
  - Kurangi eksposur kolam terhadap sinar matahari langsung untuk mengurangi pertumbuhan alga.
  - Gunakan tanaman air atau peneduh untuk membatasi jumlah cahaya yang mencapai air kolam.

2. **Penggunaan Algaecide:**
  - Jika pertumbuhan alga tidak terkendali, gunakan algaecide yang aman dan tidak berbahaya bagi ikan.

3. **Membersihkan Kolam:**
  - Bersihkan alga secara manual dari dinding dan dasar kolam secara berkala.

### Kesimpulan

Mengelola air dalam kolam semen dan sistem filtrasi yang efektif sangat penting untuk memastikan kesehatan ikan koi Anda. Dengan mengikuti panduan ini, Anda dapat menjaga kualitas air tetap optimal dan menciptakan lingkungan yang sehat bagi ikan koi Anda. Ingatlah untuk melakukan pemantauan dan pemeliharaan rutin agar kolam Anda tetap bersih dan jernih.

''',
      ),
    ];

    articles.value = articleList;
  }
}
