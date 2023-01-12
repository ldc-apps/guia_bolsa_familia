import 'package:aid_brazil/app/models/app_stream.dart';
import 'package:aid_brazil/app/modules/new/new_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webfeed/domain/rss_feed.dart';

class NewController {
  static final NewController _instance = NewController._();

  NewController._();

  factory NewController() => _instance;

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  BuildContext get context => key.currentState!.context;

  final AppStream<List<New>> newsStream = AppStream<List<New>>();

  Future<void> init() async {
    try {
      final response = await get(
          Uri.parse('https://news.google.com/rss/search?q=aux%C3%ADlio%20brasil&hl=pt-BR&gl=BR&ceid=BR%3Apt-419'));
      var rssFeed = RssFeed.parse(response.body);
      List<New> news = [];
      for (var item in rssFeed.items!) {
        String desc = item.description!;
        New newItem = New(
          title: item.title!,
          url: item.link!,
          subtitle: desc,
          date: item.pubDate,
        );
        news.add(newItem);
        newsStream.add(news);
      }
    } catch (e) {
      newsStream.add([]);
    }
  }
}
