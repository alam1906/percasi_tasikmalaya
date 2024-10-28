import '../../../domain/entities/result.dart';
import '../../../domain/entities/user_model.dart';
import '../usecase_provider/user/get_all_user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'all_user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class AllUserData extends _$AllUserData {
  @override
  Future<List<UserModel>?> build() async {
    final data = ref.read(getAllUserProvider);
    final result = await data(null);
    switch (result) {
      case Success(value: final user):
        return user;
      case Failed(message: _):
        return null;
    }
  }

  List<UserModel> getAllUserByClub({required String id}) {
    final result =
        state.valueOrNull?.where((e) => e.clubId.contains(id)).toList();

    if (result != null) {
      return result;
    } else {
      return [];
    }
  }

  Future<void> refreshAllUser() async {
    final data = ref.read(getAllUserProvider);
    final result = await data(null);
    switch (result) {
      case Success(value: final user):
        state = AsyncData(user);
      case Failed(message: _):
        state = const AsyncData(null);
    }
  }
}
