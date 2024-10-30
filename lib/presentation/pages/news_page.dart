import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:percasi_tasikmalaya/presentation/pages/create_news_page.dart';
import 'package:percasi_tasikmalaya/presentation/pages/detail_news.dart';

import 'package:percasi_tasikmalaya/presentation/providers/news_data_provider/news_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/user_data_provider/user_data_provider.dart';

import 'package:percasi_tasikmalaya/presentation/widgets/list_news.dart';
import '../widgets/basic_appbar.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({super.key});

  @override
  ConsumerState<NewsPage> createState() => _ClubPageState();
}

class _ClubPageState extends ConsumerState<NewsPage> {
  String searchNews = '';
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
                        builder: (context) => const CreateNewsPage())))
            : null,
        appBar: const BasicAppbar(
          title: 'News Page',
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      searchNews = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search News',
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
                  child: ref.watch(newsDataProvider).when(
                        data: (data) {
                          if (data == null) {
                            return const Center(child: Text("Tidak ada data"));
                          } else {
                            final result = data
                                .where((e) => e.title
                                    .toString()
                                    .toLowerCase()
                                    .startsWith(searchNews))
                                .toList();
                            result.sort((a, b) => a.date.compareTo(b.date));
                            return ListView.builder(
                              itemCount: result.length,
                              itemBuilder: (context, index) {
                                return ListNews(
                                    hero: result[index].id,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailNews(
                                                  hero: data[index].id,
                                                  title: result[index].title,
                                                  date: result[index].date,
                                                  description:
                                                      result[index].description,
                                                  url:
                                                      result[index].imageUrl)));
                                    },
                                    title: result[index].title,
                                    subTitle: result[index].date,
                                    imageUrl: result[index].imageUrl);
                              },
                            );
                          }
                        },
                        error: (e, t) => const SizedBox(),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                )
              ],
            )),
      ),
    );
  }
}
