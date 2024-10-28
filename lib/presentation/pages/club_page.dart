import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percasi_tasikmalaya/domain/entities/club_model.dart';
import 'package:percasi_tasikmalaya/presentation/pages/create_club_page.dart';
import 'package:percasi_tasikmalaya/presentation/pages/detail_club.dart';
import 'package:percasi_tasikmalaya/presentation/providers/club_data_provider/club_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/user_data_provider/user_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/list_club.dart';
import '../widgets/basic_appbar.dart';

class ClubPage extends ConsumerStatefulWidget {
  const ClubPage({super.key});

  @override
  ConsumerState<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends ConsumerState<ClubPage> {
  String searchClub = '';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        floatingActionButton: ref.watch(userDataProvider).value!.role == 'admin'
            ? FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateClubPage())))
            : null,
        appBar: const BasicAppbar(
          title: 'Club Page',
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      searchClub = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search Club',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                    child: ref.watch(clubDataProvider).when(
                        data: (data) {
                          if (data == null) {
                            return const Center(child: Text("Tidak ada data"));
                          } else {
                            List<ClubModel> result = data
                                .where((e) =>
                                    e.fullName
                                        .toString()
                                        .toLowerCase()
                                        .startsWith(searchClub) ||
                                    e.name
                                        .toString()
                                        .toLowerCase()
                                        .startsWith(searchClub))
                                .toList();
                            result.sort(
                                (a, b) => a.fullName.compareTo(b.fullName));
                            return ListView.builder(
                              itemCount: result.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailClub(
                                              clubModel: result[index]))),
                                  child: ListClub(
                                      title:
                                          '${result[index].fullName.toUpperCase()} (${result[index].name.toUpperCase()})',
                                      subTitle1:
                                          result[index].member.toString(),
                                      subTitle2:
                                          result[index].prestasi.toString(),
                                      imageUrl: result[index].imageUrl),
                                );
                              },
                            );
                          }
                        },
                        error: (e, t) => const SizedBox(),
                        loading: () => const Center(
                              child: CircularProgressIndicator(),
                            )))
              ],
            )),
      ),
    );
  }
}
