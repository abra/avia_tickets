import 'package:avia_tickets/app/style/extensions.dart';
import 'package:avia_tickets/data/local_storage.dart';
import 'package:avia_tickets/data/ticket_repository.dart';
import 'package:avia_tickets/screens/home/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.ticketRepository,
    required this.localStorageRepository,
  });

  final TicketRepository ticketRepository;
  final LocalStorage localStorageRepository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TicketRepository _ticketRepository;
  late final LocalStorage _localStorageRepository;
  late final HomeNotifier _notifier;
  static const _vGap32 = SizedBox(height: 32);

  @override
  void initState() {
    super.initState();
    _ticketRepository = widget.ticketRepository;
    _localStorageRepository = widget.localStorageRepository;
    _notifier = HomeNotifier(
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
                  _SearchTicketsBlock(notifier: _notifier),
                  _vGap32,
                  _OffersHorizontalListView(notifier: _notifier),
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

class _OffersHorizontalListView extends StatelessWidget {
  const _OffersHorizontalListView({
    required HomeNotifier notifier,
  }) : _notifier = notifier;

  final HomeNotifier _notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Музыкально отлететь',
            textAlign: TextAlign.start,
            style: context.appTextStyles.title1,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 270,
          child: ValueListenableBuilder<HomeState>(
            valueListenable: _notifier,
            builder: (BuildContext context, HomeState state, _) {
              if (state is HomeOffersSuccessUpdate) {
                final offers = state.offers;
                return ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return _OfferCard(
                      id: offers[index].id,
                      town: offers[index].town,
                      title: offers[index].title,
                      price: offers[index].price.ruPriceFormat,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 20);
                  },
                  itemCount: offers.length,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({
    required int id,
    required String title,
    required String town,
    required String price,
  })  : _id = id,
        _title = title,
        _town = town,
        _price = price;

  final int _id;
  final String _title;
  final String _town;
  final String _price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.appColors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 170,
              width: 170,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                child: Image.asset(
                  'assets/offer_images/id_$_id.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _title,
              style: context.appTextStyles.title3,
            ),
            const SizedBox(height: 8),
            Text(
              _town,
              style: context.appTextStyles.text2,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset('assets/icons/svg/airplane.svg'),
                ),
                Text(
                  'от $_price',
                  style: context.appTextStyles.text2,
                ),
              ],
            )
          ],
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

class _SearchTicketsBlock extends StatefulWidget {
  const _SearchTicketsBlock({
    required this.notifier,
  });

  final HomeNotifier notifier;

  @override
  State<_SearchTicketsBlock> createState() => _SearchTicketsBlockState();
}

class _SearchTicketsBlockState extends State<_SearchTicketsBlock> {
  final TextEditingController _textController = TextEditingController();

  HomeNotifier get _notifier => widget.notifier;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 122,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.appColors.grey3,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.appColors.grey4,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: context.appColors.black.withOpacity(0.25),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                SizedBox(
                  width: 24,
                  height: double.infinity,
                  child: FittedBox(
                    child: SvgPicture.asset(
                      'assets/icons/svg/magnifier.svg',
                      semanticsLabel: 'Search icon',
                      colorFilter: ColorFilter.mode(
                        context.appColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ValueListenableBuilder<HomeState>(
                          valueListenable: _notifier,
                          builder: (BuildContext context, HomeState state, _) {
                            if (state is HomeSearchInputSuccessUpdate) {
                              if (state.lastInput!.isNotEmpty) {
                                _textController.text = state.lastInput!;
                              }
                            }
                            return TextField(
                              onChanged: (text) {
                                _notifier.storeLastEnteredValue(text);
                              },
                              controller: _textController,
                              decoration: const InputDecoration(
                                hintText: 'Откуда - Москва',
                              ),
                              style: context.appTextStyles.buttonText.copyWith(
                                color: context.appColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          },
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: context.appColors.grey5,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Куда - Турция',
                          ),
                          style: context.appTextStyles.buttonText.copyWith(
                            color: context.appColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension NumberFormatExt on int {
  String get ruPriceFormat =>
      '${NumberFormat('###,###', 'ru_RU').format(this)} ₽';
}
