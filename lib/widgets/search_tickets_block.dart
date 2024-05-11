import 'package:avia_tickets/app/state_manager/tickets_manager.dart';
import 'package:avia_tickets/app/style/extensions.dart';
import 'package:avia_tickets/app/state_manager/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'search_modal_bottom_sheet.dart';

class SearchTicketsBlock extends StatefulWidget {
  const SearchTicketsBlock({
    super.key,
  });

  @override
  State<SearchTicketsBlock> createState() => _SearchTicketsBlockState();
}

class _SearchTicketsBlockState extends State<SearchTicketsBlock> {
  final _departureTextController = TextEditingController();
  final _arrivalTextController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  TicketsManager get _manager => context.getManager;

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
                        child: ValueListenableBuilder<TicketState>(
                          valueListenable: _manager,
                          builder: (BuildContext context, TicketState state, _) {
                            if (state is SearchInputSuccessUpdate) {
                              if (state.lastInput!.isNotEmpty) {
                                _departureTextController.text =
                                    state.lastInput!;
                              }
                            }
                            return Center(
                              child: TextField(
                                onChanged: (text) {
                                  _manager.storeLastEnteredValue(text);
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
