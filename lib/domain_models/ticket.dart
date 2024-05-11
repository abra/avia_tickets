class Ticket {
  final int id;
  final String? badge;
  final int price;
  final String providerName;
  final String company;
  final String departureTown;
  final DateTime departureDate;
  final String departureAirport;
  final String arrivalTown;
  final DateTime arrivalDate;
  final String arrivalAirport;
  final bool hasTransfer;
  final bool hasVisaTransfer;
  final bool hasLuggage;
  final int? luggagePrice;
  final bool hasHandLuggage;
  final String? handLuggageSize;
  final bool isReturnable;
  final bool isExchangable;

  Ticket({
    required this.id,
    required this.badge,
    required this.price,
    required this.providerName,
    required this.company,
    required this.departureTown,
    required this.departureDate,
    required this.departureAirport,
    required this.arrivalTown,
    required this.arrivalDate,
    required this.arrivalAirport,
    required this.hasTransfer,
    required this.hasVisaTransfer,
    required this.hasLuggage,
    required this.luggagePrice,
    required this.hasHandLuggage,
    required this.handLuggageSize,
    required this.isReturnable,
    required this.isExchangable,
  });

  String get departureTimeStr {
    final hh = departureDate.hour.toString().padLeft(2, '0');
    final mm = departureDate.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  String get arrivalTimeStr {
    final hh = arrivalDate.hour.toString().padLeft(2, '0');
    final mm = arrivalDate.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  String get travelTimeStr {
    final hh = arrivalDate.difference(departureDate).inHours;
    final mm = arrivalDate.difference(departureDate).inMinutes.remainder(60);
    final travelTime = (hh + mm / 60);
    return travelTime.toStringAsFixed(1);
  }

  String get transferStr => hasTransfer ? 'С пересадкой' : 'Без пересадок';
}
