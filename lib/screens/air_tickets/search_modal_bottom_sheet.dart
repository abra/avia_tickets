import 'package:avia_tickets/app/style/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchModalBottomSheet extends StatefulWidget {
  const SearchModalBottomSheet({
    super.key,
    required this.departureCity,
  });

  final String departureCity;

  @override
  State<SearchModalBottomSheet> createState() => _SearchModalBottomSheetState();
}

class _SearchModalBottomSheetState extends State<SearchModalBottomSheet> {
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
            _RouteSearchForm(widget: widget, textController: _textController),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: _RouteTipsElementsRow(textController: _textController),
            ),
            const SizedBox(height: 24),
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
          ],
        ),
      ),
    );
  }
}

class _RouteSearchForm extends StatelessWidget {
  const _RouteSearchForm({
    required this.widget,
    required TextEditingController textController,
  }) : _textController = textController;

  final SearchModalBottomSheet widget;
  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                        style: context.appTextStyles.buttonText.copyWith(
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
    );
  }
}

enum _RouteOption {
  complex('Сложный маршрут', 'assets/icons/svg/route.svg'),
  anywhere('Куда угодно', 'assets/icons/svg/earth-icon.svg'),
  weekend('Выходные', 'assets/icons/svg/calendar-icon.svg'),
  hotTickets('Горящие билеты', 'assets/icons/svg/fire.svg');

  final String label;
  final String iconPath;

  const _RouteOption(this.label, this.iconPath);
}

class _RouteOptionButton extends StatelessWidget {
  final _RouteOption option;
  final VoidCallback onTap;

  const _RouteOptionButton({
    required this.option,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 48,
        height: 48,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _getColor(context, option),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 48,
                maxHeight: 48,
              ),
              child: SvgPicture.asset(option.iconPath),
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor(BuildContext context, _RouteOption option) {
    switch (option) {
      case _RouteOption.complex:
        return context.appColors.green;
      case _RouteOption.anywhere:
        return context.appColors.blue;
      case _RouteOption.weekend:
        return context.appColors.darkBlue;
      case _RouteOption.hotTickets:
        return context.appColors.red;
    }
  }
}

class _RouteTipsElementsRow extends StatelessWidget {
  const _RouteTipsElementsRow({
    required this.textController,
  });

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      children: _RouteOption.values.map((option) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _RouteOptionButton(
              option: option,
              onTap: () {
                if (option == _RouteOption.anywhere) {
                  textController.text = option.label;
                } else {
                  _navigateToOptionScreen(context, option);
                }
              },
            ),
            const SizedBox(height: 8),
            Text(
              option.label,
              textAlign: TextAlign.center,
              style: context.appTextStyles.title4,
            ),
          ],
        );
      }).toList(),
    );
  }

  void _navigateToOptionScreen(BuildContext context, _RouteOption option) {
    Navigator.of(context).push(
      MaterialPageRoute<Widget>(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(
              'На главную',
              style: context.appTextStyles.title1,
            ),
            leading: IconButton(
              onPressed: () => Navigator.of(context).popAndPushNamed('/'),
              icon: SvgPicture.asset(
                'assets/icons/svg/left-arrow.svg',
              ),
            ),
          ),
          body: Container(
            color: _getColor(context, option),
            child: Center(
              child: Text(
                option.label,
                textAlign: TextAlign.center,
                style: context.appTextStyles.text2.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor(BuildContext context, _RouteOption option) {
    switch (option) {
      case _RouteOption.complex:
        return context.appColors.darkGreen;
      case _RouteOption.anywhere:
        return context.appColors.blue;
      case _RouteOption.weekend:
        return context.appColors.darkBlue;
      case _RouteOption.hotTickets:
        return context.appColors.red;
    }
  }
}
