import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../models/offer_rm.dart';
import '../models/ticket_offer_rm.dart';
import '../models/ticket_rm.dart';
import 'ticket_api_service_interface.dart';

part 'ticket_api_service.g.dart';

const String baseUrl = 'https://run.mocky.io/v3/';
const String offers = '00727197-24ae-48a0-bcb3-63eb35d7a9de';
const String ticketOffers = '3424132d-a51a-4613-b6c9-42b2d214f35f';
const String tickets = '2dbc0999-86bf-4c08-8671-bac4b7a5f7eb';

@RestApi(baseUrl: baseUrl)
abstract class TicketApiService implements TicketApiServiceInterface {
  factory TicketApiService(Dio dio) = _TicketApiService;

  @override
  @GET(offers)
  Future<List<OfferRM>> getOffers();

  @override
  @GET(ticketOffers)
  Future<List<TicketOfferRM>> getTicketOffers();

  @override
  @GET(tickets)
  Future<List<TicketRM>> getTickets();
}
