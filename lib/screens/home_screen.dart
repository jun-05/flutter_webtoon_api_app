import 'package:flutter/material.dart';
import 'package:webtoon_api_app/services/api_service.dart';
import 'package:webtoon_api_app/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "Today's Toon",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                itemBuilder: (context, index) {
                  var webtoon = snapshot.data![index];
                  return Webtoon(webtoon.title, webtoon.thumb, webtoon.id);
                },
                separatorBuilder: (context, index) => const SizedBox(
                      width: 30,
                    ),
                itemCount: snapshot.data!.length);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
