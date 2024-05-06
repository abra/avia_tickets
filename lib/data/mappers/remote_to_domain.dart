import 'package:avia_tickets/domain_models/offer.dart';
import 'package:avia_tickets/domain_models/ticket.dart';
import 'package:avia_tickets/domain_models/ticket_offer.dart';

import '../models/offer_list.dart';
import '../models/ticket_list.dart';
import '../models/ticket_offer_list.dart';

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
      departureTown: departure.town,
      departureDate: departure.date,
      departureAirport: departure.airport,
      arrivalTown: arrival.town,
      arrivalDate: arrival.date,
      arrivalAirport: arrival.airport,
      hasTransfer: hasTransfer,
      hasVisaTransfer: hasVisaTransfer,
      hasLuggage: luggage.hasLuggage,
      luggagePrice: luggage.price?.value,
      hasHandLuggage: handLuggage.hasHandLuggage,
      handLuggageSize: handLuggage.size,
      isReturnable: isReturnable,
      isExchangable: isExchangable,
    );
  }
}
