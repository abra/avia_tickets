import '../models/offer_list.dart';
import '../models/ticket_list.dart';
import '../models/ticket_offer_list.dart';

abstract interface class TicketApiServiceInterface {
  Future<OfferList> getOffers();

  Future<TicketOfferList> getTicketOffers();

  Future<TicketList> getTickets();
}
