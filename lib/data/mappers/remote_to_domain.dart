import 'package:avia_tickets/domain_models/offer.dart';
import 'package:avia_tickets/domain_models/ticket.dart';
import 'package:avia_tickets/domain_models/ticket_offer.dart';

import '../models/offer_rm.dart';
import '../models/ticket_offer_rm.dart';
import '../models/ticket_rm.dart';

extension OfferRMtoDomain on OfferRM {
  Offer toDomain() {
    return Offer(
      id: id,
      title: title,
      town: town,
      price: price.value,
    );
  }
}

extension TicketOfferRMtoDomain on TicketOfferRM {
  TicketOffer toDomain() {
    return TicketOffer(
      id: id,
      title: title,
      timeRange: timeRange,
      price: price.value,
    );
  }
}

extension TicketRMtoDomain on TicketRM {
  Ticket toDomain() {
    return Ticket(
      id: id,
      badge: badge,
      price: price.value,
      providerName: providerName,
      company: company,
      departureTown: departure.town.toString(),
      departureDate: departure.date,
      departureAirport: departure.airport.name,
      arrivalTown: arrival.town.toString(),
      arrivalDate: arrival.date,
      arrivalAirport: arrival.airport.name,
      hasTransfer: hasTransfer,
      hasVisaTransfer: hasVisaTransfer,
      hasLuggage: luggage.hasLuggage,
      luggagePrice: luggage.price.value,
      hasHandLuggage: handLuggage.hasHandLuggage,
      handLuggageSize: handLuggage.size,
      isReturnable: isReturnable,
      isExchangable: isExchangable,
    );
  }
}
