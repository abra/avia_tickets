import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'app/style/app_colors_theme.dart';
import 'app/style/app_dimensions_theme.dart';
import 'app/style/app_texts_theme.dart';
import 'data/ticket_repository.dart';
import 'data/service/ticket_api_service.dart';
import 'domain_models/ticket_offer.dart';

void main() {
  final dio = Dio(BaseOptions(contentType: "application/json"));
  runApp(
    MyApp(
      repo: TicketRepository(ticketApiService: TicketApiService(dio)),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.repo,
  });

  final TicketRepository repo;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<TicketOffer>> offers;

  @override
  void initState() {
    super.initState();
    offers = widget.repo.getTicketOffers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Theme.of(context).copyWith(
        extensions: [
          AppDimensionsTheme.main(),
          AppColorsTheme.dark(),
          AppTextsTheme.main(),
        ],
      ),
      home: Scaffold(
        body: FutureBuilder<List<TicketOffer>>(
          future: offers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final offers = snapshot.data!;
              return ListView.builder(
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${offers[index].id}'),
                    subtitle: Text(offers[index].title),
                    trailing: Text(offers[index].price.toString()),
                    onTap: () {},
                  );
                },
              );
            } else if (snapshot.hasError) {
              log(snapshot.error.toString());
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
