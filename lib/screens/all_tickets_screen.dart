import 'package:avia_tickets/app/state_manager/extensions.dart';
import 'package:avia_tickets/app/state_manager/tickets_manager.dart';
import 'package:avia_tickets/app/style/extensions.dart';
import 'package:avia_tickets/domain_models/ticket.dart';
import 'package:avia_tickets/widgets/offers_horizontal_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllTicketsScreen extends StatefulWidget {
  const AllTicketsScreen({
    super.key,
    required this.departureCity,
    required this.arrivalCity,
  });

  final String departureCity;
  final String arrivalCity;

  @override
  State<AllTicketsScreen> createState() => _AllTicketsScreenState();
}

class _AllTicketsScreenState extends State<AllTicketsScreen> {
  TicketsManager get _manager => context.getManager;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _manager.getTickets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: kToolbarHeight,
              ),
              ColoredBox(
                color: context.appColors.grey2,
                child: SizedBox(
                  height: kToolbarHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/svg/left-arrow.svg',
                          colorFilter: ColorFilter.mode(
                            context.appColors.blue,
                            BlendMode.srcIn,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.departureCity}-${widget.arrivalCity}',
                            style: context.appTextStyles.title3,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Все билеты',
                            style: context.appTextStyles.text2
                                .copyWith(color: context.appColors.blue),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 34),
              Flexible(
                child: ValueListenableBuilder<TicketState>(
                  valueListenable: _manager,
                  builder: (BuildContext context, TicketState state, _) {
                    if (state is TicketsSuccessUpdate) {
                      final tickets = state.tickets;
                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: tickets.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _TicketItem(
                            ticket: tickets[index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 16);
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TicketItem extends StatelessWidget {
  const _TicketItem({
    required this.ticket,
  });

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 125,
      width: width - 32,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 8,
            child: SizedBox(
              height: 117,
              width: width - 32,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.appColors.grey2,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 20,
                    right: 16,
                    bottom: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticket.price.ruPriceFormat.toString(),
                        style: context.appTextStyles.title2.copyWith(
                          color: context.appColors.white,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 38,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: context.appColors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ticket.departureTimeStr,
                                  style: context.appTextStyles.text2.copyWith(
                                    color: context.appColors.white,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  ticket.departureAirport,
                                  style: context.appTextStyles.text2.copyWith(
                                    color: context.appColors.grey5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '-',
                                  style: context.appTextStyles.text2.copyWith(
                                    color: context.appColors.white,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  ticket.arrivalTimeStr,
                                  style: context.appTextStyles.text2.copyWith(
                                    color: context.appColors.white,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  ticket.arrivalAirport,
                                  style: context.appTextStyles.text2.copyWith(
                                    color: context.appColors.grey5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              '${ticket.travelTimeStr}ч в пути',
                                          style: context.appTextStyles.text2
                                              .copyWith(
                                            color: context.appColors.white,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' / ',
                                          style: context.appTextStyles.text2
                                              .copyWith(
                                            color: context.appColors.grey5,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ticket.transferStr,
                                          style: context.appTextStyles.text2
                                              .copyWith(
                                            color: context.appColors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                ],
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
          ),
          if (ticket.badge != null)
            Positioned(
              left: 0,
              top: 0,
              child: SizedBox(
                // width: 126,
                height: 21,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.appColors.blue,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '${ticket.badge}',
                        style: context.appTextStyles.title4
                            .copyWith(color: context.appColors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
