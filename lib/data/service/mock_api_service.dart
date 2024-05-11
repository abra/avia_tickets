import 'dart:convert';

import 'package:avia_tickets/data/models/offer_list.dart';
import 'package:avia_tickets/data/models/ticket_list.dart';
import 'package:avia_tickets/data/models/ticket_offer_list.dart';
import 'package:flutter/services.dart';

import 'ticket_api_service_interface.dart';

class MockApiService implements TicketApiServiceInterface {
  @override
  Future<OfferList> getOffers() async {
    final data = await _loadJson('assets/json/offers.json');
    return OfferList.fromJson(data);
  }

  @override
  Future<TicketOfferList> getTicketOffers() async {
    final data = await _loadJson('assets/json/offers_tickets.json');
    return TicketOfferList.fromJson(data);
  }

  @override
  Future<TicketList> getTickets() async {
    final data =  await _loadJson('assets/json/tickets.json');
    return TicketList.fromJson(data);
  }

  Future<Map<String, dynamic>> _loadJson(String fileName) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final jsonString = await rootBundle.loadString(fileName);
    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    return data;
  }
}
