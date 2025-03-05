class WikipediaResponseModel {
  final bool success;
  final List<WikiPageModel> pages;
  final String? errorMessage;

  WikipediaResponseModel({
    required this.success,
    required this.pages,
    this.errorMessage,
  });

  factory WikipediaResponseModel.fromJson(Map<String, dynamic> json) {
    List<WikiPageModel> pageList = WikiPageModel.fromJsonList(json);

    return WikipediaResponseModel(
      success: pageList.isNotEmpty,
      pages: pageList,
      errorMessage: pageList.isEmpty ? "No data found" : null,
    );
  }

  factory WikipediaResponseModel.withError(String error) {
    return WikipediaResponseModel(
      success: false,
      pages: [],
      errorMessage: error,
    );
  }
}


class WikiPageModel {
  final String pageId;
  final String title;
  final String extract;
  final String imageUrl;
  final String fullUrl;
  bool isLiked;

  WikiPageModel({
    required this.pageId,
    required this.title,
    required this.extract,
    required this.imageUrl,
    required this.fullUrl,
    this.isLiked = false,
  });

  factory WikiPageModel.fromJson(Map<String, dynamic> json) {
    return WikiPageModel(
      pageId: json['pageid'].toString(),
      title: json['title'] ?? "No title",
      extract: json['extract'] ?? "No description available",
      imageUrl: json['thumbnail'] != null ? json['thumbnail']['source'] : "",
      fullUrl: json['fullurl'] ?? "",
    );
  }

  static List<WikiPageModel> fromJsonList(Map<String, dynamic> json) {
    List<WikiPageModel> list = [];
    if (json.containsKey("query") && json["query"].containsKey("pages")) {
      json["query"]["pages"].forEach((key, value) {
        list.add(WikiPageModel.fromJson(value));
      });
    }
    return list;
  }
}
