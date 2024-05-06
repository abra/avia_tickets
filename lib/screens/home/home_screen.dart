import 'package:avia_tickets/app/style/extensions.dart';
import 'package:avia_tickets/data/local_storage_repository.dart';
import 'package:avia_tickets/data/ticket_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.ticketRepository,
    required this.localStorageRepository,
  });

  final TicketRepository ticketRepository;
  final LocalStorageRepository localStorageRepository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TicketRepository ticketRepo;
  late final LocalStorageRepository localStorageRepo;

  @override
  void initState() {
    super.initState();
    ticketRepo = widget.ticketRepository;
    localStorageRepo = widget.localStorageRepository;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ColoredBox(
        color: context.appColors.blue,
      ),
    );
  }
}
