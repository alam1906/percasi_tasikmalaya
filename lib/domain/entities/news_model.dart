import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_model.freezed.dart';

part 'news_model.g.dart';

@freezed
class NewsModel with _$NewsModel {
  factory NewsModel({
    required String id,
    required String date,
    required String dateTime,
    required String description,
    required String title,
    required String imageUrl,
  }) = _NewsModel;

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);
}
