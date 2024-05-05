import 'package:avia_tickets/domain_models/offer.dart';
import 'package:avia_tickets/domain_models/ticket.dart';
import 'package:avia_tickets/domain_models/ticket_offer.dart';

import 'mappers/remote_to_domain.dart';
import 'service/ticket_api_service_interface.dart';

class TicketRepository {
  const TicketRepository({
    required TicketApiServiceInterface ticketApiService,
  }) : _ticketApiService = ticketApiService;

  final TicketApiServiceInterface _ticketApiService;

  Future<List<Offer>> getOffers() async {
    final data = await _ticketApiService.getOffers();
    return data.offerList.map((offer) => offer.toDomain()).toList();
  }

  Future<List<TicketOffer>> getTicketOffers() async {
    final data = await _ticketApiService.getTicketOffers();
    return data.ticketsOfferList
        .map((ticketOffer) => ticketOffer.toDomain())
        .toList();
  }

  Future<List<Ticket>> getTickets() async {
    final data = await _ticketApiService.getTickets();
    return data.ticketList.map((ticket) => ticket.toDomain()).toList();
  }
}
