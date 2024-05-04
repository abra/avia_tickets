// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketRM _$TicketRMFromJson(Map<String, dynamic> json) => TicketRM(
      id: (json['id'] as num).toInt(),
      badge: json['badge'] as String,
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
      providerName: json['providerName'] as String,
      company: json['company'] as String,
      departure: Arrival.fromJson(json['departure'] as Map<String, dynamic>),
      arrival: Arrival.fromJson(json['arrival'] as Map<String, dynamic>),
      hasTransfer: json['hasTransfer'] as bool,
      hasVisaTransfer: json['hasVisaTransfer'] as bool,
      luggage: Luggage.fromJson(json['luggage'] as Map<String, dynamic>),
      handLuggage:
          HandLuggage.fromJson(json['handLuggage'] as Map<String, dynamic>),
      isReturnable: json['isReturnable'] as bool,
      isExchangable: json['isExchangable'] as bool,
    );

Map<String, dynamic> _$TicketRMToJson(TicketRM instance) => <String, dynamic>{
      'id': instance.id,
      'badge': instance.badge,
      'price': instance.price,
      'providerName': instance.providerName,
      'company': instance.company,
      'departure': instance.departure,
      'arrival': instance.arrival,
      'hasTransfer': instance.hasTransfer,
      'hasVisaTransfer': instance.hasVisaTransfer,
      'luggage': instance.luggage,
      'handLuggage': instance.handLuggage,
      'isReturnable': instance.isReturnable,
      'isExchangable': instance.isExchangable,
    };

Arrival _$ArrivalFromJson(Map<String, dynamic> json) => Arrival(
      town: $enumDecode(_$TownEnumMap, json['town']),
      date: DateTime.parse(json['date'] as String),
      airport: $enumDecode(_$AirportEnumMap, json['airport']),
    );

Map<String, dynamic> _$ArrivalToJson(Arrival instance) => <String, dynamic>{
      'town': _$TownEnumMap[instance.town]!,
      'date': instance.date.toIso8601String(),
      'airport': _$AirportEnumMap[instance.airport]!,
    };

const _$TownEnumMap = {
  Town.EMPTY: 'EMPTY',
  Town.TOWN: 'TOWN',
};

const _$AirportEnumMap = {
  Airport.AER: 'AER',
  Airport.VKO: 'VKO',
};

HandLuggage _$HandLuggageFromJson(Map<String, dynamic> json) => HandLuggage(
      hasHandLuggage: json['hasHandLuggage'] as bool,
      size: json['size'] as String,
    );

Map<String, dynamic> _$HandLuggageToJson(HandLuggage instance) =>
    <String, dynamic>{
      'hasHandLuggage': instance.hasHandLuggage,
      'size': instance.size,
    };

Luggage _$LuggageFromJson(Map<String, dynamic> json) => Luggage(
      hasLuggage: json['hasLuggage'] as bool,
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LuggageToJson(Luggage instance) => <String, dynamic>{
      'hasLuggage': instance.hasLuggage,
      'price': instance.price,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'value': instance.value,
    };
