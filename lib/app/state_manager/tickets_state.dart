part of 'tickets_manager.dart';

sealed class TicketState extends Equatable {
  const TicketState();
}

class TicketsLoading extends TicketState {
  @override
  List<Object?> get props => [];
}

class OffersSuccessUpdate extends TicketState {
  const OffersSuccessUpdate({
    required this.offers,
  });

  final List<Offer> offers;

  @override
  List<Object?> get props => [
        offers,
      ];
}

class TicketOffersSuccessUpdate extends TicketState {
  const TicketOffersSuccessUpdate({
    required this.ticketOffers,
  });

  final List<TicketOffer> ticketOffers;

  @override
  List<Object?> get props => [
        ticketOffers,
      ];
}

class TicketsSuccessUpdate extends TicketState {
  const TicketsSuccessUpdate({
    required this.tickets,
  });

  final List<Ticket> tickets;

  @override
  List<Object?> get props => [
        tickets,
      ];
}

class SearchInputSuccessUpdate extends TicketState {
  const SearchInputSuccessUpdate({
    required this.lastInput,
  });

  final String? lastInput;

  @override
  List<Object?> get props => [
        lastInput,
      ];
}

class TicketUpdateFailure extends TicketState {
  const TicketUpdateFailure({
    required this.error,
  }) : errorMessage = '$error';

  final dynamic error;
  final String errorMessage;

  @override
  List<Object?> get props => [
        error,
        errorMessage,
      ];
}

class SearchInputUpdateFailure extends TicketState {
  const SearchInputUpdateFailure({
    required this.error,
  }) : errorMessage = '$error';

  final dynamic error;
  final String errorMessage;

  @override
  List<Object?> get props => [
        error,
        errorMessage,
      ];
}
