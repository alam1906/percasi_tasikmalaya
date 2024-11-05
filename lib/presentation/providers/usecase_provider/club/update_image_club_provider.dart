import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percasi_tasikmalaya/domain/usecase/club/update_image_club/update_image_club.dart';
import 'package:percasi_tasikmalaya/presentation/providers/repositories_provider/club_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'update_image_club_provider.g.dart';

@riverpod
UpdateImageClub updateImageClub(Ref ref) =>
    UpdateImageClub(clubRepository: ref.read(clubRepositoryProvider));
