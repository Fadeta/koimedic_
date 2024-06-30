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
        title: 'Understanding Koi Fish',
        imageUrl: 'https://example.com/koi1.jpg',
        description: 'Learn about different types of Koi fish.',
      ),
      Article(
        title: 'Koi Fish Care Tips',
        imageUrl: 'https://example.com/koi2.jpg',
        description: 'Essential tips for keeping your Koi fish healthy.',
      ),
    ];

    articles.value = articleList;
  }
}
