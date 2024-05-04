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
}
