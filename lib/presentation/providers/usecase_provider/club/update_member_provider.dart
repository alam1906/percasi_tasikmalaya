import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percasi_tasikmalaya/domain/usecase/club/update_member/update_member.dart';
import 'package:percasi_tasikmalaya/presentation/providers/repositories_provider/club_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'update_member_provider.g.dart';

@riverpod
UpdateMember updateMember(Ref ref) =>
    UpdateMember(clubRepository: ref.read(clubRepositoryProvider));
