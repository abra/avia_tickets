import 'dart:developer';
import 'dart:io';

import 'package:avia_tickets/app/state_manager/extensions.dart';
import 'package:avia_tickets/app/state_manager/tickets_manager.dart';
import 'package:avia_tickets/app/style/extensions.dart';
import 'package:avia_tickets/widgets/offers_horizontal_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'all_tickets_screen.dart';

class CountrySelectedScreen extends StatefulWidget {
  const CountrySelectedScreen({
    super.key,
    required this.departureCity,
    required this.arrivalCity,
  });

  final String departureCity;
  final String arrivalCity;

  @override
  State<CountrySelectedScreen> createState() => _CountrySelectedScreenState();
}

class _CountrySelectedScreenState extends State<CountrySelectedScreen> {
  late TextEditingController _departureTextController;
  late TextEditingController _arrivalTextController;

  TicketsManager get _manager => context.getManager;

  @override
  void initState() {
    super.initState();
    _departureTextController = TextEditingController(
      text: widget.departureCity,
    );
    _arrivalTextController = TextEditingController(
      text: widget.arrivalCity,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _manager.getTicketOffers();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru_RU', null);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            _InputFieldsForm(
              departureTextController: _departureTextController,
              arrivalTextController: _arrivalTextController,
            ),
            const SizedBox(height: 12),
            const _ChipsListView(),
            const SizedBox(height: 24),
            const _TicketsOffersListView(),
            const SizedBox(height: 24),
            _ShowAllTicketOffersButton(
              departureCity: _departureTextController.text,
              arrivalCity: _arrivalTextController.text,
            ),
          ],
        ),
      ),
    );
  }
}

class _ShowAllTicketOffersButton extends StatelessWidget {
  const _ShowAllTicketOffersButton({
    required this.departureCity,
    required this.arrivalCity,
  });

  final String departureCity;
  final String arrivalCity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<String>(
              builder: (context) => AllTicketsScreen(
                departureCity: departureCity,
                arrivalCity: arrivalCity,
              ),
            ),
          );
        },
        child: const Text('Показать все билеты'),
      ),
    );
  }
}

class _TicketsOffersListView extends StatelessWidget {
  const _TicketsOffersListView();

  @override
  Widget build(BuildContext context) {
    TicketsManager manager = context.getManager;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.appColors.grey3,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Прямые рельсы',
                style: context.appTextStyles.title2,
              ),
              const SizedBox(height: 8),
              ValueListenableBuilder<TicketState>(
                valueListenable: manager,
                builder: (BuildContext context, TicketState state, _) {
                  if (state is TicketOffersSuccessUpdate) {
                    final ticketOffers = state.ticketOffers;
                    return ListView.separated(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: ticketOffers.length,
                      itemBuilder: (BuildContext context, int index) {
                        final ticketOffer = _TicketOffersListItem(
                          index: index,
                          title: ticketOffers[index].title,
                          price: ticketOffers[index].price,
                          timeRange: ticketOffers[index].timeRange,
                        );
                        if (index == ticketOffers.length - 1) {
                          return Column(
                            children: [
                              ticketOffer,
                              Divider(
                                  height: 1, color: context.appColors.grey4),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Показать все',
                                    style: context.appTextStyles.buttonText
                                        .copyWith(
                                      color: context.appColors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return ticketOffer;
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 1,
                          color: context.appColors.grey4,
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TicketOffersListItem extends StatelessWidget {
  const _TicketOffersListItem({
    required this.index,
    required this.title,
    required this.price,
    required this.timeRange,
  });

  final int index;
  final String title;
  final int price;
  final List<String> timeRange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: 24,
              height: 24,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: _itemColor(context, index),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: context.appTextStyles.title4,
                          ),
                          const Spacer(),
                          Text(
                            '${price.ruPriceFormat} >',
                            style: context.appTextStyles.title4.copyWith(
                              color: context.appColors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    timeRange.join(' ').toString(),
                    overflow: TextOverflow.ellipsis,
                    style: context.appTextStyles.title4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _itemColor(BuildContext context, int index) => switch (index) {
        0 => context.appColors.red,
        1 => context.appColors.blue,
        2 => context.appColors.white,
        // TODO: Handle this case.
        int() => throw UnimplementedError(),
      };
}

class _ChipsListView extends StatefulWidget {
  const _ChipsListView();

  @override
  State<_ChipsListView> createState() => _ChipsListViewState();
}

class _ChipsListViewState extends State<_ChipsListView> {
  DateTime _returnDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // Return date chip
          SizedBox(
            height: 33,
            child: ActionChip(
              side: const BorderSide(
                color: Colors.transparent,
              ),
              avatar: SvgPicture.asset(
                'assets/icons/svg/plus.svg',
                semanticsLabel: 'Airplane icon',
                colorFilter: ColorFilter.mode(
                  context.appColors.white,
                  BlendMode.srcIn,
                ),
              ),
              backgroundColor: context.appColors.grey3,
              disabledColor: context.appColors.grey3,
              labelStyle: context.appTextStyles.title4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
              iconTheme: IconThemeData(
                color: context.appColors.white,
              ),
              onPressed: () async {
                final date = await _showDatePicker(context);
                if (date != null) {
                  log('$date');
                }
              },
              label: const Text(
                'обратно',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Departure date chip
          const SizedBox(width: 8),
          SizedBox(
            height: 33,
            child: ActionChip(
              side: const BorderSide(
                color: Colors.transparent,
              ),
              backgroundColor: context.appColors.grey3,
              disabledColor: context.appColors.grey3,
              labelStyle: context.appTextStyles.title4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
              iconTheme: IconThemeData(
                color: context.appColors.white,
              ),
              onPressed: () async {
                final date = await _showDatePicker(context);
                if (date != null) {
                  setState(() {
                    _returnDate = date;
                  });
                }
              },
              label: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: DateFormat.d('ru_RU').format(_returnDate),
                    ),
                    TextSpan(
                      text: ' ${DateFormat.MMM('ru_RU').format(_returnDate)}',
                    ),
                    TextSpan(
                      text: ', ${DateFormat.E('ru_RU').format(_returnDate)}',
                    ),
                  ],
                  style: TextStyle(
                    color: context.appColors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Passengers chip
          SizedBox(
            height: 33,
            child: ActionChip(
              avatar: SvgPicture.asset(
                'assets/icons/svg/person.svg',
                semanticsLabel: 'People icon',
                colorFilter: ColorFilter.mode(
                  context.appColors.grey5,
                  BlendMode.srcIn,
                ),
              ),
              side: const BorderSide(
                color: Colors.transparent,
              ),
              onPressed: () {},
              backgroundColor: context.appColors.grey3,
              disabledColor: context.appColors.grey3,
              labelStyle: context.appTextStyles.title4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
              iconTheme: IconThemeData(
                color: context.appColors.white,
              ),
              label: Text(
                '1,эконом',
                style: TextStyle(
                  color: context.appColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Filters
          SizedBox(
            height: 33,
            child: ActionChip(
              avatar: SvgPicture.asset(
                'assets/icons/svg/filter.svg',
                semanticsLabel: 'People icon',
                colorFilter: ColorFilter.mode(
                  context.appColors.white,
                  BlendMode.srcIn,
                ),
              ),
              side: const BorderSide(
                color: Colors.transparent,
              ),
              onPressed: () {},
              backgroundColor: context.appColors.grey3,
              disabledColor: context.appColors.grey3,
              labelStyle: context.appTextStyles.title4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
              iconTheme: IconThemeData(
                color: context.appColors.white,
              ),
              label: Text(
                '1,эконом',
                style: TextStyle(
                  color: context.appColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> _showDatePicker(
    BuildContext context,
  ) async {
    if (Platform.isAndroid) {
      return await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
      );
    } else {
      // show cupertino date picker
      DateTime? selected;
      await showCupertinoModalPopup<DateTime?>(
        context: context,
        builder: (BuildContext context) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: context.appColors.grey3,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SizedBox(
              height: 300,
              child: CupertinoDatePicker(
                backgroundColor: context.appColors.grey3,
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                minimumDate: DateTime(1970),
                maximumDate: DateTime.now(),
                onDateTimeChanged: (DateTime value) {
                  selected = value;
                },
              ),
            ),
          );
        },
      );
      return selected;
    }
  }
}

class _InputFieldsForm extends StatelessWidget {
  const _InputFieldsForm({
    required TextEditingController departureTextController,
    required TextEditingController arrivalTextController,
  })  : _departureTextController = departureTextController,
        _arrivalTextController = arrivalTextController;

  final TextEditingController _departureTextController;
  final TextEditingController _arrivalTextController;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.appColors.grey3,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        height: 90,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(width: 16),
            SizedBox(
              height: double.infinity,
              width: 24,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: IconButton(
                  iconSize: 24,
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                    'assets/icons/svg/left-arrow.svg',
                    semanticsLabel: 'Search icon',
                    colorFilter: ColorFilter.mode(
                      context.appColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              controller: _departureTextController,
                              decoration: const InputDecoration(),
                              textAlign: TextAlign.start,
                              style: context.appTextStyles.buttonText.copyWith(
                                color: context.appColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            final tmp = _departureTextController.value.text;
                            _departureTextController.text =
                                _arrivalTextController.value.text;
                            _arrivalTextController.text = tmp;
                          },
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            'assets/icons/svg/change.svg',
                            width: 24,
                            height: 24,
                            semanticsLabel: 'Swap towns icon',
                            colorFilter: ColorFilter.mode(
                              context.appColors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: context.appColors.grey5,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              controller: _arrivalTextController,
                              decoration: const InputDecoration(
                                hintText: 'Куда - Турция',
                              ),
                              style: context.appTextStyles.buttonText.copyWith(
                                color: context.appColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _arrivalTextController.clear();
                          },
                          icon: SvgPicture.asset(
                            'assets/icons/svg/close-icon.svg',
                            width: 12,
                            height: 12,
                            semanticsLabel: 'Close icon',
                            colorFilter: ColorFilter.mode(
                              context.appColors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        // Chips
      ),
    );
  }
}
