import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percasi_tasikmalaya/data/firebase/news_firebase.dart';
import 'package:percasi_tasikmalaya/domain/repositories/news_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'news_repository_provider.g.dart';

@riverpod
NewsRepository newsRepository(Ref ref) => NewsFirebase();
