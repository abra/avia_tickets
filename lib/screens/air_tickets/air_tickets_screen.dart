import 'package:avia_tickets/app/style/extensions.dart';
import 'package:avia_tickets/data/local_storage.dart';
import 'package:avia_tickets/data/ticket_repository.dart';
import 'package:flutter/material.dart';

import 'air_tickets_notifier.dart';
import 'offers_horizontal_list_view.dart';
import 'search_tickets_block.dart';

class AirTicketsScreen extends StatefulWidget {
  const AirTicketsScreen({
    super.key,
    required this.ticketRepository,
    required this.localStorageRepository,
  });

  final TicketRepository ticketRepository;
  final LocalStorage localStorageRepository;

  @override
  State<AirTicketsScreen> createState() => _AirTicketsScreenState();
}

class _AirTicketsScreenState extends State<AirTicketsScreen> {
  late final TicketRepository _ticketRepository;
  late final LocalStorage _localStorageRepository;
  late final AirTicketsNotifier _notifier;
  static const _vGap32 = SizedBox(height: 32);

  @override
  void initState() {
    super.initState();
    _ticketRepository = widget.ticketRepository;
    _localStorageRepository = widget.localStorageRepository;
    _notifier = AirTicketsNotifier(
      ticketRepository: _ticketRepository,
      localStorage: _localStorageRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const _HeaderText(),
                  _vGap32,
                  SearchTicketsBlock(notifier: _notifier),
                  _vGap32,
                  OffersHorizontalListView(notifier: _notifier),
                  _vGap32,
                  const _ShowAllOffersButton(),
                  _vGap32,
                  const _SuggestionsBlock(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SuggestionsBlock extends StatelessWidget {
  const _SuggestionsBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ваш первый раз',
          textAlign: TextAlign.start,
          style: context.appTextStyles.title1,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 170,
                    width: 170,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/other_images/img_${index + 1}.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Место ${index + 1}',
                    style: context.appTextStyles.text1,
                  ),
                  const Text('Lorem ipsum'),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 20),
          ),
        ),
      ],
    );
  }
}

class _ShowAllOffersButton extends StatelessWidget {
  const _ShowAllOffersButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.appColors.grey4,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Center(
          child: Text(
            'Показать все места',
            style: context.appTextStyles.buttonText,
          ),
        ),
      ),
    );
  }
}

class _HeaderText extends StatelessWidget {
  const _HeaderText();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Center(
        child: Text(
          'Поиск дешевых авиабилетов',
          textAlign: TextAlign.center,
          style: context.appTextStyles.title1,
        ),
      ),
    );
  }
}
