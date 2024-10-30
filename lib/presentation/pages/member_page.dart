import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percasi_tasikmalaya/core/config/utils/extension_string.dart';
import 'package:percasi_tasikmalaya/domain/entities/user_model.dart';
import 'package:percasi_tasikmalaya/presentation/pages/create_leader_page.dart';
import 'package:percasi_tasikmalaya/presentation/pages/create_member_page.dart';

import 'package:percasi_tasikmalaya/presentation/providers/all_user_data_provider/all_user_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/club_data_provider/club_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/user_data_provider/user_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/list_member.dart';
import '../widgets/basic_appbar.dart';

class MemberPage extends ConsumerStatefulWidget {
  const MemberPage({super.key});

  @override
  ConsumerState<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends ConsumerState<MemberPage> {
  String searchMember = '';
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(userDataProvider).valueOrNull;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        floatingActionButton: data!.role == 'admin'
            ? FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateLeaderPage())))
            : data.role == 'leader'
                ? FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateMemberPage())))
                : null,

        // appbar
        appBar: const BasicAppbar(title: 'Member Page'),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _searchMember(setState),
                  const SizedBox(height: 5),
                  _listMember(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // list member
  _listMember() {
    return Expanded(
      child: ref.watch(allUserDataProvider).when(
            data: (data) {
              if (data == null) {
                return const Center(child: Text("Tidak ada data"));
              } else {
                List<UserModel>? result = data
                    .where(
                        (e) => e.username.toLowerCase().contains(searchMember))
                    .toList();
                result.sort((a, b) => a.username.compareTo(b.username));
                result.removeWhere((e) => e.username.contains('admin'));
                return ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    final club = ref
                        .watch(userDataProvider.notifier)
                        .getNameClub(id: result[index].clubId);
                    return ListMember(
                        hero: result[index].uid,
                        title: result[index].username.toString().capitalize(),
                        subTitle1: club.toUpperCase(),
                        subtTitle2: result[index].rating.toString(),
                        imageUrl: result[index].imageUrl!);
                  },
                );
              }
            },
            error: (e, t) => const SizedBox(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }

  // search member
  _searchMember(StateSetter setState) {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchMember = value.toLowerCase();
        });
      },
      decoration: InputDecoration(
        hintText: "Search Member",
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
