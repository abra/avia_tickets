import 'package:json_annotation/json_annotation.dart';

part 'ticket_offer_list.g.dart';

@JsonSerializable()
class TicketOfferList {
  final List<TicketOfferRM> ticketsOfferList;

  TicketOfferList({
    required this.ticketsOfferList,
  });

  factory TicketOfferList.fromJson(Map<String, dynamic> json) =>
      _$TicketOfferListFromJson(json);
}

@JsonSerializable()
class TicketOfferRM {
  final int id;
  final String title;
  final List<String> timeRange;
  final Price price;

  TicketOfferRM({
    required this.id,
    required this.title,
    required this.timeRange,
    required this.price,
  });

  factory TicketOfferRM.fromJson(Map<String, dynamic> json) =>
      _$TicketOfferRMFromJson(json);
}

@JsonSerializable()
class Price {
  final int value;

  Price({
    required this.value,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}
