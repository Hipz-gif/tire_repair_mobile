class BannerModel {
  final int adId;
  final String title;
  final String content;
  final String adUrl;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;

  BannerModel({
    required this.adId,
    required this.title,
    required this.content,
    required this.adUrl,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      adId: json['ad_id'],
      title: json['title'],
      content: json['content'],
      adUrl: json['ad_url'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
