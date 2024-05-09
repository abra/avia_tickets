import 'package:avia_tickets/app/style/extensions.dart';
import 'package:avia_tickets/data/local_storage.dart';
import 'package:avia_tickets/data/ticket_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'air_tickets_notifier.dart';
import 'offers_horizontal_list_view.dart';
import 'search_modal_bottom_sheet.dart';

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
        return SearchModalBottomSheet(
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
