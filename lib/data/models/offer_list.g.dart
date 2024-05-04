// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferList _$OfferListFromJson(Map<String, dynamic> json) => OfferList(
      offerList: (json['offers'] as List<dynamic>)
          .map((e) => OfferRM.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OfferListToJson(OfferList instance) => <String, dynamic>{
      'offers': instance.offerList,
    };

OfferRM _$OfferRMFromJson(Map<String, dynamic> json) => OfferRM(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      town: json['town'] as String,
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfferRMToJson(OfferRM instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'town': instance.town,
      'price': instance.price,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'value': instance.value,
    };
