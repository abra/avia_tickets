import 'package:avia_tickets/app/state_manager/tickets_manager.dart';
import 'package:avia_tickets/app/style/extensions.dart';
import 'package:avia_tickets/app/state_manager/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class OffersHorizontalListView extends StatelessWidget {
  const OffersHorizontalListView({
    super.key,
  });

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
          child: ValueListenableBuilder<TicketState>(
            valueListenable: context.getManager,
            builder: (BuildContext context, TicketState state, _) {
              if (state is OffersSuccessUpdate) {
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

extension NumberFormatExt on int {
  String get ruPriceFormat =>
      '${NumberFormat('###,###', 'ru_RU').format(this)} ₽';
}
