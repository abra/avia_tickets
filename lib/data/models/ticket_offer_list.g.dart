// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_offer_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketOfferList _$TicketOfferListFromJson(Map<String, dynamic> json) =>
    TicketOfferList(
      ticketsOfferList: (json['tickets_offers'] as List<dynamic>)
          .map((e) => TicketOfferRM.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TicketOfferListToJson(TicketOfferList instance) =>
    <String, dynamic>{
      'tickets_offers': instance.ticketsOfferList,
    };

TicketOfferRM _$TicketOfferRMFromJson(Map<String, dynamic> json) =>
    TicketOfferRM(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      timeRange: (json['time_range'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TicketOfferRMToJson(TicketOfferRM instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'time_range': instance.timeRange,
      'price': instance.price,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'value': instance.value,
    };
