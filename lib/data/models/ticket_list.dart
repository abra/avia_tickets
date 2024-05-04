import 'package:json_annotation/json_annotation.dart';

part 'ticket_list.g.dart';

@JsonSerializable()
class TicketList {
  @JsonKey(name: 'tickets')
  final List<TicketRM> ticketList;

  TicketList({
    required this.ticketList,
  });

  factory TicketList.fromJson(Map<String, dynamic> json) =>
      _$TicketListFromJson(json);
}

@JsonSerializable()
class TicketRM {
  final int id;
  final String? badge;
  final Price price;
  @JsonKey(name: 'provider_name')
  final String providerName;
  final String company;
  final Arrival departure;
  final Arrival arrival;
  @JsonKey(name: 'has_transfer')
  final bool hasTransfer;
  @JsonKey(name: 'has_visa_transfer')
  final bool hasVisaTransfer;
  final Luggage luggage;
  @JsonKey(name: 'hand_luggage')
  final HandLuggage handLuggage;
  @JsonKey(name: 'is_returnable')
  final bool isReturnable;
  @JsonKey(name: 'is_exchangable')
  final bool isExchangable;

  TicketRM({
    required this.id,
    required this.badge,
    required this.price,
    required this.providerName,
    required this.company,
    required this.departure,
    required this.arrival,
    required this.hasTransfer,
    required this.hasVisaTransfer,
    required this.luggage,
    required this.handLuggage,
    required this.isReturnable,
    required this.isExchangable,
  });

  @override
  factory TicketRM.fromJson(Map<String, dynamic> json) =>
      _$TicketRMFromJson(json);

}

@JsonSerializable()
class Arrival {
  @JsonKey(name: 'town')
  final String town;
  final DateTime date;
  @JsonKey(name: 'airport')
  final String airport;

  Arrival({
    required this.town,
    required this.date,
    required this.airport,
  });

  factory Arrival.fromJson(Map<String, dynamic> json) =>
      _$ArrivalFromJson(json);
}

@JsonSerializable()
class HandLuggage {
  @JsonKey(name: 'has_hand_luggage')
  final bool hasHandLuggage;
  final String? size;

  HandLuggage({
    required this.hasHandLuggage,
    required this.size,
  });

  factory HandLuggage.fromJson(Map<String, dynamic> json) =>
      _$HandLuggageFromJson(json);
}

@JsonSerializable()
class Luggage {
  @JsonKey(name: 'has_luggage')
  final bool hasLuggage;
  final Price? price;

  Luggage({
    required this.hasLuggage,
    required this.price,
  });

  factory Luggage.fromJson(Map<String, dynamic> json) =>
      _$LuggageFromJson(json);
}

@JsonSerializable()
class Price {
  final int value;

  Price({
    required this.value,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}
