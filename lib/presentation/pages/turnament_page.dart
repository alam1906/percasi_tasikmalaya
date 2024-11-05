import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percasi_tasikmalaya/presentation/pages/create_turnament_page.dart';
import 'package:percasi_tasikmalaya/presentation/providers/turnament_data_provider/turnament_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/user_data_provider/user_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/basic_appbar.dart';
import 'package:percasi_tasikmalaya/presentation/widgets/list_turnament.dart';

class TurnamentPage extends ConsumerStatefulWidget {
  const TurnamentPage({super.key});

  @override
  ConsumerState<TurnamentPage> createState() => _TurnamentPageState();
}

class _TurnamentPageState extends ConsumerState<TurnamentPage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataProvider).valueOrNull;
    return Scaffold(
        floatingActionButton: user?.role == 'admin'
            ? FloatingActionButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateTurnamentPage())),
                child: const Icon(Icons.add),
              )
            : null,
        appBar: const BasicAppbar(title: "Info Turnament"),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 10 / 19,
              children: ref.watch(turnamentDataProviderProvider).when(
                  data: (data) {
                    return List.generate(data.length, (index) {
                      return ListTurnament(
                          tag: data[index].id,
                          title: data[index].title,
                          imageUrl: data[index].imageUrl);
                    });
                  },
                  error: (e, t) => [],
                  loading: () => []),
            )));
  }
}
