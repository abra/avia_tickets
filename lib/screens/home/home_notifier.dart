import 'package:avia_tickets/data/local_storage.dart';
import 'package:avia_tickets/data/ticket_repository.dart';
import 'package:avia_tickets/domain_models/offer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeNotifier extends ValueNotifier<HomeState> {
  HomeNotifier({
    required TicketRepository ticketRepository,
    required LocalStorage localStorage,
  })  : _ticketRepository = ticketRepository,
        _localStorage = localStorage,
        super(HomeLoading()) {
    _init();
  }

  final TicketRepository _ticketRepository;
  final LocalStorage _localStorage;

  Future<void> _init() async {
    try {
      await getLastEnteredValue();
      await getOffers();
    } catch (e) {
      value = HomeUpdateFailure(error: e);
    }
  }

  Future<void> getOffers() async {
    final offers = await _ticketRepository.getOffers();
    value = HomeOffersSuccessUpdate(offers: offers);
  }

  Future<void> getLastEnteredValue() async {
    final lastValue = await _localStorage.getValue('from');
    if (lastValue == null) return;
    value = HomeSearchInputSuccessUpdate(lastInput: lastValue);
  }

  Future<void> storeLastEnteredValue(String value) async {
    await _localStorage.storeValue('from', value);
  }
}
