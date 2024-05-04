import 'package:json_annotation/json_annotation.dart';

part 'ticket_rm.g.dart';

@JsonSerializable()
class TicketRM {
  final int id;
  final String badge;
  final Price price;
  final String providerName;
  final String company;
  final Arrival departure;
  final Arrival arrival;
  final bool hasTransfer;
  final bool hasVisaTransfer;
  final Luggage luggage;
  final HandLuggage handLuggage;
  final bool isReturnable;
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

  factory TicketRM.fromJson(Map<String, dynamic> json) =>
      _$TicketRMFromJson(json);
}

@JsonSerializable()
class Arrival {
  final Town town;
  final DateTime date;
  final Airport airport;

  Arrival({
    required this.town,
    required this.date,
    required this.airport,
  });

  factory Arrival.fromJson(Map<String, dynamic> json) =>
      _$ArrivalFromJson(json);
}

enum Airport { AER, VKO }

enum Town { EMPTY, TOWN }

@JsonSerializable()
class HandLuggage {
  final bool hasHandLuggage;
  final String size;

  HandLuggage({
    required this.hasHandLuggage,
    required this.size,
  });

  factory HandLuggage.fromJson(Map<String, dynamic> json) =>
      _$HandLuggageFromJson(json);
}

@JsonSerializable()
class Luggage {
  final bool hasLuggage;
  final Price price;

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
