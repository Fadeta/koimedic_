class KoiData {
  String? name;
  String? species;
  String? age;

  KoiData({this.name, this.species, this.age});
}

class Article {
  final String title;
  final String imageUrl;
  final String description;

  Article(
      {required this.title, required this.imageUrl, required this.description});
}
