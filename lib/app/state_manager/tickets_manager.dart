import 'package:avia_tickets/data/local_storage.dart';
import 'package:avia_tickets/data/ticket_repository.dart';
import 'package:avia_tickets/domain_models/offer.dart';
import 'package:avia_tickets/domain_models/ticket.dart';
import 'package:avia_tickets/domain_models/ticket_offer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'tickets_state.dart';

class TicketsManager extends ValueNotifier<TicketState> {
  TicketsManager({
    required TicketRepository ticketRepository,
    required LocalStorage localStorage,
  })  : _ticketRepository = ticketRepository,
        _localStorage = localStorage,
        super(TicketsLoading()) {
    _init();
  }

  final TicketRepository _ticketRepository;
  final LocalStorage _localStorage;

  Future<void> _init() async {
    try {
      await getLastEnteredValue();
      await getOffers();
    } catch (e) {
      value = TicketUpdateFailure(error: e);
    }
  }

  Future<void> getOffers() async {
    final offers = await _ticketRepository.getOffers();
    value = OffersSuccessUpdate(offers: offers);
  }

  Future<void> getTicketOffers() async {
    final ticketOffers = await _ticketRepository.getTicketOffers();
    value = TicketOffersSuccessUpdate(ticketOffers: ticketOffers);
  }

  Future<void> getTickets() async {
    final tickets = await _ticketRepository.getTickets();
    value = TicketsSuccessUpdate(tickets: tickets);
  }

  Future<void> getLastEnteredValue() async {
    final lastValue = await _localStorage.getValue('from');
    if (lastValue == null) return;
    value = SearchInputSuccessUpdate(lastInput: lastValue);
  }

  Future<void> storeLastEnteredValue(String value) async {
    await _localStorage.storeValue('from', value);
  }
}
