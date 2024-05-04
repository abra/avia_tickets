import '../models/offer_rm.dart';
import '../models/ticket_offer_rm.dart';
import '../models/ticket_rm.dart';

abstract interface class TicketApiServiceInterface {
  Future<List<OfferRM>> getOffers();
  Future<List<TicketOfferRM>> getTicketOffers();
  Future<List<TicketRM>> getTickets();
}