import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percasi_tasikmalaya/core/config/utils/extension_string.dart';
import 'package:percasi_tasikmalaya/presentation/pages/club_page.dart';
import 'package:percasi_tasikmalaya/presentation/pages/detail_news.dart';
import 'package:percasi_tasikmalaya/presentation/pages/member_page.dart';
import 'package:percasi_tasikmalaya/presentation/pages/my_account.dart';
import 'package:percasi_tasikmalaya/presentation/pages/my_club.dart';
import 'package:percasi_tasikmalaya/presentation/pages/turnament_page.dart';
import 'package:percasi_tasikmalaya/presentation/providers/club_data_provider/club_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/news_data_provider/news_data_provider.dart';
import 'news_page.dart';
import '../providers/user_data_provider/user_data_provider.dart';
import '../widgets/list_news.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int bannerIndex = 1;
  late final PageController _bannerController;

  @override
  void initState() {
    ref.read(clubDataProvider);
    _bannerController = PageController(initialPage: 1);
    super.initState();
  }

  @override
  void dispose() {
    _bannerController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        width: 250,
        child: Center(
          child: ElevatedButton(
              onPressed: () async {
                await ref.read(userDataProvider.notifier).logout();
              },
              child: const Text("Logout")),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _greeting(ref),
                const SizedBox(height: 30),
                _banner(),
                const SizedBox(height: 20),
                _menu(),
                const SizedBox(height: 20),
                _latestNews(ref),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _latestNews(WidgetRef ref) {
    final data = ref.watch(newsDataProvider.notifier).getNewsLimit();
    data?.sort((a, b) => a.date.compareTo(b.date));

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Latest News",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: data != null
                  ? List.generate(data.length, (index) {
                      return ListNews(
                          hero: '${data[index].id}$index',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailNews(
                                        hero: '${data[index].id}$index',
                                        title: data[index].title,
                                        date: data[index].date,
                                        description: data[index].description,
                                        url: data[index].imageUrl)));
                          },
                          title: data[index].title,
                          subTitle: data[index].date,
                          imageUrl: data[index].imageUrl);
                    })
                  : [
                      const Center(
                        child: Text("Tidak ada data"),
                      )
                    ]),
        ],
      ),
    );
  }

  _menu() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            " Menu Service",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _itemMenu(
                    icon: Icons.people,
                    title: "Member",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MemberPage())),
                  ),
                  _itemMenu(
                    icon: Icons.card_membership,
                    title: "Club",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ClubPage())),
                  ),
                  _itemMenu(
                    icon: Icons.newspaper,
                    title: "News",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NewsPage())),
                  ),
                  _itemMenu(
                    icon: Icons.info,
                    title: "Tourney",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TurnamentPage())),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _itemMenu(
                    icon: Icons.my_library_books,
                    title: "MyClub",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyClub())),
                  ),
                  _itemMenu(
                    icon: Icons.manage_history,
                    title: "MyAccount",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyAccount())),
                  ),
                  _itemMenu(icon: Icons.class_, title: "Course"),
                  _itemMenu(
                    icon: Icons.logout,
                    title: "Logout",
                    onTap: () => ref.read(userDataProvider.notifier).logout(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _itemMenu({
    required String title,
    VoidCallback? onTap,
    required IconData icon,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap ?? () {},
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  _banner() {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: StatefulBuilder(builder: (context, setState) {
        return Stack(
          children: [
            PageView(
              pageSnapping: true,
              controller: _bannerController,
              onPageChanged: (value) {
                setState(() {
                  bannerIndex = value;
                });
              },
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.yellow,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Align(
              alignment: const Alignment(0, 0.9),
              child: Wrap(
                spacing: 5,
                alignment: WrapAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 8,
                    decoration: BoxDecoration(
                        color: bannerIndex == 0 ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Container(
                    width: 20,
                    height: 8,
                    decoration: BoxDecoration(
                        color: bannerIndex == 1 ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Container(
                    width: 20,
                    height: 8,
                    decoration: BoxDecoration(
                        color: bannerIndex == 2 ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  _greeting(WidgetRef ref) {
    final data = ref.watch(userDataProvider).valueOrNull;
    return SizedBox(
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: data == null
                      ? null
                      : CachedNetworkImageProvider(data.imageUrl!),
                  radius: 23,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome Back",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      data == null ? '' : data.username.capitalize(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Icon(
                    Icons.menu,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
