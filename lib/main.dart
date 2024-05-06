import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'data/local_storage/shared_prefs_storage.dart';
import 'data/local_storage_repository.dart';
import 'data/service/ticket_api_service.dart';
import 'data/ticket_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = Dio(BaseOptions(contentType: "application/json"));
  final ticketRepository = TicketRepository(
    ticketApiService: TicketApiService(dio),
  );
  final localStorageRepository = LocalStorageRepository(
    storage: SharedPrefsStorage(),
  );
  runApp(
    App(
      ticketRepository: ticketRepository,
      localStorageRepository: localStorageRepository,
    ),
  );
}
