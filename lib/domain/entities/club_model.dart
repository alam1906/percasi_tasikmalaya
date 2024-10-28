import 'package:freezed_annotation/freezed_annotation.dart';
part 'club_model.freezed.dart';
part 'club_model.g.dart';

@freezed
class ClubModel with _$ClubModel {
  factory ClubModel({
    required String id,
    required String name,
    required String fullName,
    required bool hasLeader,
    required int member,
    required int prestasi,
    String? imageUrl,
    String? description,
    Map<String, dynamic>? listImageUrl,
  }) = _ClubModel;

  factory ClubModel.fromJson(Map<String, dynamic> json) =>
      _$ClubModelFromJson(json);
}
