import 'package:json_annotation/json_annotation.dart';

part 'offer_rm.g.dart';

@JsonSerializable()
class OfferRM {
  final int id;
  final String title;
  final String town;
  final Price price;

  OfferRM({
    required this.id,
    required this.title,
    required this.town,
    required this.price,
  });

  factory OfferRM.fromJson(Map<String, dynamic> json) =>
      _$OfferRMFromJson(json);
}

@JsonSerializable()
class Price {
  final int value;

  Price({
    required this.value,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}
