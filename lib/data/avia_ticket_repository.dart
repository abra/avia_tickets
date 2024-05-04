import 'package:avia_tickets/domain_models/offer.dart';
import 'package:avia_tickets/domain_models/ticket.dart';
import 'package:avia_tickets/domain_models/ticket_offer.dart';

import 'mappers/remote_to_domain.dart';
import 'service/ticket_api_service_interface.dart';

class AviaTicketRepository {
  const AviaTicketRepository({
    required TicketApiServiceInterface ticketApiService,
  }) : _ticketApiService = ticketApiService;

  final TicketApiServiceInterface _ticketApiService;

  Future<List<Offer>> getOffers() async {
    final offers = await _ticketApiService.getOffers();
    return offers.map((offer) => offer.toDomain()).toList();
  }

  Future<List<TicketOffer>> getTicketOffers() async {
    final ticketOffers = await _ticketApiService.getTicketOffers();
    return ticketOffers.map((ticketOffer) => ticketOffer.toDomain()).toList();
  }

  Future<List<Ticket>> getTickets() async {
    final tickets = await _ticketApiService.getTickets();
    return tickets.map((ticket) => ticket.toDomain()).toList();
  }
}
