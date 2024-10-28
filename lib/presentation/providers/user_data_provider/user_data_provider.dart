import 'package:flutter/material.dart';
import 'package:percasi_tasikmalaya/domain/entities/club_model.dart';
import 'package:percasi_tasikmalaya/domain/usecase/club/update_member/update_member_params.dart';
import 'package:percasi_tasikmalaya/presentation/providers/club_data_provider/club_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/usecase_provider/club/update_member_provider.dart';
import '../../../domain/usecase/user/register_member.dart/register_member_params.dart';
import '../all_user_data_provider/all_user_data_provider.dart';
import '../usecase_provider/user/get_all_user_provider.dart';
import '../usecase_provider/user/register_member.dart';
import '../../../domain/entities/result.dart';
import '../../../domain/usecase/user/update_user/update_user_params.dart';
import '../usecase_provider/user/get_email_provider.dart';
import '../usecase_provider/user/update_user_provider.dart';
import '../../../domain/entities/user_model.dart';
import '../../../domain/usecase/user/login/login.dart';
import '../../../domain/usecase/user/register_leader/register_leader.dart';
import '../usecase_provider/user/get_logged_in_user_provider.dart';
import '../usecase_provider/user/login_provider.dart';
import '../usecase_provider/user/logout_provider.dart';
import '../usecase_provider/user/register_leader.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<UserModel?> build() async {
    final getLoggedInUser = ref.read(getLoggedInUserProvider);
    final result = await getLoggedInUser(null);
    switch (result) {
      case Success(value: final user):
        return user;
      case Failed(message: _):
        return null;
    }
  }

  ClubModel getClub() {
    final data = ref.watch(clubDataProvider).valueOrNull;
    final result =
        data!.where((e) => e.id.contains(state.value!.clubId)).toList()[0];
    return result;
  }

  // update user
  Future<void> updateUser({required UserModel user}) async {
    state = const AsyncLoading();
    final updateUser = ref.read(updateUserProvider);
    final result = await updateUser(UpdateUserParams(user: user));
    if (result.isSuccess) {
      await ref.read(allUserDataProvider.notifier).refreshAllUser();
      state = AsyncData(result.resultValue);
    } else {
      state =
          AsyncError(FlutterError(result.errorMessage!), StackTrace.current);
      state = AsyncData(state.valueOrNull);
    }
  }

  // refresh data
  Future<void> refreshData() async {
    final getLoggedInUser = ref.read(getLoggedInUserProvider);
    final result = await getLoggedInUser(null);
    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  // login
  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    final data = ref.read(loginProvider);
    final result = await data(LoginParams(email: email, password: password));
    switch (result) {
      case Success(value: final user):
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  // logout
  Future<void> logout() async {
    final data = ref.read(logoutProvider);
    final result = await data(null);
    if (result is Success) {
      state = const AsyncData(null);
    } else {
      state =
          AsyncError(FlutterError(result.errorMessage!), StackTrace.current);
      state = AsyncData(state.valueOrNull);
    }
  }

  // registerLeader
  Future<void> registerLeader({
    required String email,
    required String password,
    required String clubId,
    required String imageUrl,
    required int rating,
    String role = 'leader',
    required String username,
    required String passwordAdmin,
    bool isLeader = true,
  }) async {
    state = const AsyncLoading();
    // check admin login
    final emailAdmin = ref.read(getEmailProvider);
    final resultEmailAdmin = await emailAdmin(null);
    final login = ref.read(loginProvider);
    final resultLogin = await login(LoginParams(
        email: resultEmailAdmin.resultValue!, password: passwordAdmin));
    if (resultLogin.isSuccess) {
      // register member
      final data = ref.read(registerLeaderProvider);
      final result = await data(RegisterLeaderParams(
        email: email,
        password: password,
        clubId: clubId,
        imageUrl: imageUrl,
        rating: rating,
        role: role,
        username: username,
        passwordAdmin: passwordAdmin,
      ));
      if (result.isSuccess) {
        final update = ref.read(updateMemberProvider);
        final updateMember =
            await update(UpdateMemberParams(id: clubId, isLeader: isLeader));
        if (updateMember.isSuccess) {
          ref.read(clubDataProvider.notifier).refreshData();
        }
        // logout
        final logout = ref.read(logoutProvider);
        final resultLogout = await logout(null);
        if (resultLogout.isSuccess) {
          // login back to admin
          final login = ref.read(loginProvider);
          final resultLogin = await login(LoginParams(
              email: resultEmailAdmin.resultValue!, password: passwordAdmin));
          if (resultLogin.isSuccess) {
            await ref.read(allUserDataProvider.notifier).refreshAllUser();
            state = AsyncData(resultLogin.resultValue);
          } else {
            state = AsyncError(
                FlutterError(result.errorMessage!), StackTrace.current);
            state = AsyncData(state.value);
          }
        } else {
          state = AsyncError(
              FlutterError(result.errorMessage!), StackTrace.current);
          state = AsyncData(state.value);
        }
      } else {
        state =
            AsyncError(FlutterError(result.errorMessage!), StackTrace.current);
        state = AsyncData(state.value);
      }
    } else {
      state = AsyncError(
          FlutterError(resultLogin.errorMessage!), StackTrace.current);
      state = AsyncData(state.value);
    }
  }

  // registerMember
  Future<void> registerMember({
    required String email,
    required String password,
    required String clubId,
    required String imageUrl,
    required int rating,
    String role = 'member',
    required String username,
    required String passwordAdmin,
    bool isLeader = true,
  }) async {
    state = const AsyncLoading();
    // check admin login
    final emailAdmin = ref.read(getEmailProvider);
    final resultEmailAdmin = await emailAdmin(null);
    final login = ref.read(loginProvider);
    final resultLogin = await login(LoginParams(
        email: resultEmailAdmin.resultValue!, password: passwordAdmin));
    if (resultLogin.isSuccess) {
      // register member
      final data = ref.read(registerMemberProvider);
      final result = await data(RegisterMemberParams(
        email: email,
        password: password,
        clubId: clubId,
        imageUrl: imageUrl,
        rating: rating,
        role: role,
        username: username,
        passwordAdmin: passwordAdmin,
      ));
      if (result.isSuccess) {
        final update = ref.read(updateMemberProvider);
        final updateMember =
            await update(UpdateMemberParams(id: clubId, isLeader: isLeader));
        if (updateMember.isSuccess) {
          ref.read(clubDataProvider.notifier).refreshData();
        }
        // logout
        final logout = ref.read(logoutProvider);
        final resultLogout = await logout(null);
        if (resultLogout.isSuccess) {
          // login back to admin
          final login = ref.read(loginProvider);
          final resultLogin = await login(LoginParams(
              email: resultEmailAdmin.resultValue!, password: passwordAdmin));
          if (resultLogin.isSuccess) {
            await ref.read(allUserDataProvider.notifier).refreshAllUser();
            state = AsyncData(resultLogin.resultValue);
          } else {
            state = AsyncError(
                FlutterError(result.errorMessage!), StackTrace.current);
            state = AsyncData(state.value);
          }
        } else {
          state = AsyncError(
              FlutterError(result.errorMessage!), StackTrace.current);
          state = AsyncData(state.value);
        }
      } else {
        state =
            AsyncError(FlutterError(result.errorMessage!), StackTrace.current);
        state = AsyncData(state.value);
      }
    } else {
      state = AsyncError(
          FlutterError(resultLogin.errorMessage!), StackTrace.current);
      state = AsyncData(state.value);
    }
  }

  Future<List<UserModel>?> getAllUser() async {
    final data = ref.read(getAllUserProvider);
    final result = await data(null);
    if (result.isSuccess) {
      return result.resultValue!;
    } else {
      return null;
    }
  }
}
