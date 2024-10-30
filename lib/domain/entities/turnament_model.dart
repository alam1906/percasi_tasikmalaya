import 'package:freezed_annotation/freezed_annotation.dart';
part 'turnament_model.g.dart';
part 'turnament_model.freezed.dart';

@freezed
class TurnamentModel with _$TurnamentModel {
  factory TurnamentModel({
    required String id,
    required String title,
    required String date,
    required String imageUrl,
  }) = _TurnamentModel;

  factory TurnamentModel.fromJson(Map<String, dynamic> json) =>
      _$TurnamentModelFromJson(json);
}
