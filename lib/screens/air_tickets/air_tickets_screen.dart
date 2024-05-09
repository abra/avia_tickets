import 'package:avia_tickets/app/style/extensions.dart';
import 'package:avia_tickets/data/local_storage.dart';
import 'package:avia_tickets/data/ticket_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'air_tickets_notifier.dart';

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
    required AirTicketsNotifier notifier,
  }) : _notifier = notifier;

  final AirTicketsNotifier _notifier;

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

  final AirTicketsNotifier notifier;

  @override
  State<_SearchTicketsBlock> createState() => _SearchTicketsBlockState();
}

class _SearchTicketsBlockState extends State<_SearchTicketsBlock> {
  final _departureTextController = TextEditingController();
  final _arrivalTextController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  AirTicketsNotifier get _notifier => widget.notifier;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() async {
      if (_focusNode.hasFocus) {
        final place = await _showSearchModalBottomSheet(context);
        _focusNode.unfocus();
        if (place != null) {
          _arrivalTextController.text = place;
        }
      }
    });
  }

  Future<String?> _showSearchModalBottomSheet(
    BuildContext context,
  ) async {
    return await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _SearchModalBottomSheet(
          departureCity: _departureTextController.text,
        );
      },
    );
  }

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ValueListenableBuilder<HomeState>(
                          valueListenable: _notifier,
                          builder: (BuildContext context, HomeState state, _) {
                            if (state is HomeSearchInputSuccessUpdate) {
                              if (state.lastInput!.isNotEmpty) {
                                _departureTextController.text =
                                    state.lastInput!;
                              }
                            }
                            return Center(
                              child: TextField(
                                onChanged: (text) {
                                  _notifier.storeLastEnteredValue(text);
                                },
                                controller: _departureTextController,
                                decoration: const InputDecoration(
                                  hintText: 'Откуда - Москва',
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                style:
                                    context.appTextStyles.buttonText.copyWith(
                                  color: context.appColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
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
                        child: Center(
                          child: TextField(
                            controller: _arrivalTextController,
                            focusNode: _focusNode,
                            decoration: const InputDecoration(
                              hintText: 'Куда - Турция',
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            style: context.appTextStyles.buttonText.copyWith(
                              color: context.appColors.white,
                              fontWeight: FontWeight.w600,
                            ),
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

class _SearchModalBottomSheet extends StatefulWidget {
  const _SearchModalBottomSheet({
    required this.departureCity,
  });

  final String departureCity;

  @override
  State<_SearchModalBottomSheet> createState() =>
      _SearchModalBottomSheetState();
}

class _SearchModalBottomSheetState extends State<_SearchModalBottomSheet> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - kToolbarHeight,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: 40,
                height: 5,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context.appColors.grey5,
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 96,
              width: MediaQuery.of(context).size.width - 32,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.appColors.grey3,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/svg/airplane2.svg'),
                            const SizedBox(width: 8),
                            Text(
                              widget.departureCity,
                              style: context.appTextStyles.buttonText.copyWith(
                                color: context.appColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Divider(height: 2, color: context.appColors.grey4),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/svg/magnifier.svg'),
                            Expanded(
                              child: TextField(
                                controller: _textController,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                  hintText: 'Куда - Турция',
                                  contentPadding: EdgeInsets.only(left: 16),
                                ),
                                style:
                                    context.appTextStyles.buttonText.copyWith(
                                  color: context.appColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: IconButton(
                                onPressed: () {
                                  _textController.clear();
                                },
                                padding: EdgeInsets.zero,
                                icon: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxHeight: 12,
                                    maxWidth: 12,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/svg/close-icon.svg',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 90,
                    width: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<Widget>(
                                builder: (context) => Scaffold(
                                  appBar: AppBar(
                                    title: Text(
                                      'На главную',
                                      style: context.appTextStyles.title1,
                                    ),
                                    leading: IconButton(
                                      onPressed: () => Navigator.of(context)
                                          .popAndPushNamed('/'),
                                      icon: SvgPicture.asset(
                                        'assets/icons/svg/left-arrow.svg',
                                      ),
                                    ),
                                  ),
                                  body: Container(
                                    color: context.appColors.darkGreen,
                                    child: Center(
                                      child: Text(
                                        'Сложный маршрут',
                                        textAlign: TextAlign.center,
                                        style: context.appTextStyles.text2
                                            .copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 48,
                            height: 48,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: context.appColors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 48,
                                    maxHeight: 48,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/svg/route.svg',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            'Сложный маршрут',
                            textAlign: TextAlign.center,
                            style: context.appTextStyles.title4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 90,
                    width: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _textController.text = 'Куда угодно';
                          },
                          child: SizedBox(
                            width: 48,
                            height: 48,
                            child: Center(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: context.appColors.blue,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxWidth: 24,
                                      maxHeight: 24,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/svg/earth-icon.svg',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            'Куда угодно',
                            textAlign: TextAlign.center,
                            style: context.appTextStyles.title4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 90,
                    width: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<Widget>(
                                builder: (context) => Scaffold(
                                  appBar: AppBar(
                                    title: Text(
                                      'На главную',
                                      style: context.appTextStyles.title1,
                                    ),
                                    leading: IconButton(
                                      onPressed: () => Navigator.of(context)
                                          .popAndPushNamed('/'),
                                      icon: SvgPicture.asset(
                                        'assets/icons/svg/left-arrow.svg',
                                      ),
                                    ),
                                  ),
                                  body: Container(
                                    color: context.appColors.darkBlue,
                                    child: Center(
                                      child: Text(
                                        'Выходные',
                                        textAlign: TextAlign.center,
                                        style: context.appTextStyles.text2
                                            .copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 48,
                            height: 48,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: context.appColors.darkBlue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 48,
                                    maxHeight: 48,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/svg/calendar-icon.svg',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            'Выходные',
                            textAlign: TextAlign.center,
                            style: context.appTextStyles.title4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 90,
                    width: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<Widget>(
                                builder: (context) => Scaffold(
                                  appBar: AppBar(
                                    title: Text(
                                      'На главную',
                                      style: context.appTextStyles.title1,
                                    ),
                                    leading: IconButton(
                                      onPressed: () => Navigator.of(context)
                                          .popAndPushNamed('/'),
                                      icon: SvgPicture.asset(
                                        'assets/icons/svg/left-arrow.svg',
                                      ),
                                    ),
                                  ),
                                  body: Container(
                                    color: context.appColors.red,
                                    child: Center(
                                      child: Text(
                                        'Горящие билеты',
                                        textAlign: TextAlign.center,
                                        style: context.appTextStyles.text2
                                            .copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 48,
                            height: 48,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: context.appColors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 48,
                                    maxHeight: 48,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/svg/fire.svg',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            'Горящие билеты',
                            textAlign: TextAlign.center,
                            style: context.appTextStyles.title4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            /// Arrival cards
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.appColors.grey3,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 48,
                              height: 48,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/city_images/istanbul.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Стамбул',
                                    style: context.appTextStyles.title3,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Популярное направление',
                                    style: context.appTextStyles.text2.copyWith(
                                      color: context.appColors.grey5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(color: context.appColors.grey4),
                        Row(
                          children: [
                            SizedBox(
                              width: 48,
                              height: 48,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/city_images/sochi.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Сочи',
                                    style: context.appTextStyles.title3,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Популярное направление',
                                    style: context.appTextStyles.text2.copyWith(
                                      color: context.appColors.grey5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(color: context.appColors.grey4),
                        Row(
                          children: [
                            SizedBox(
                              width: 48,
                              height: 48,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/city_images/phuket.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Пхукет',
                                    style: context.appTextStyles.title3,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Популярное направление',
                                    style: context.appTextStyles.text2.copyWith(
                                      color: context.appColors.grey5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 8),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute<Widget>(
            //         builder: (context) => Scaffold(
            //           appBar: AppBar(
            //             title: Text(departureCity),
            //             leading: IconButton(
            //               onPressed: () =>
            //                   Navigator.of(context).popAndPushNamed('/home'),
            //               icon: const Icon(Icons.close),
            //             ),
            //           ),
            //           body: Container(
            //             color: Colors.green,
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            //   child: const Text('Click me'),
            // ),
          ],
        ),
      ),
    );
  }
}

extension NumberFormatExt on int {
  String get ruPriceFormat =>
      '${NumberFormat('###,###', 'ru_RU').format(this)} ₽';
}
