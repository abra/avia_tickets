part of 'air_tickets_notifier.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeOffersSuccessUpdate extends HomeState {
  const HomeOffersSuccessUpdate({
    required this.offers,
  });

  final List<Offer> offers;

  @override
  List<Object?> get props => [
        offers,
      ];
}

class HomeSearchInputSuccessUpdate extends HomeState {
  const HomeSearchInputSuccessUpdate({
    required this.lastInput,
  });

  final String? lastInput;

  @override
  List<Object?> get props => [
        lastInput,
      ];
}

class HomeUpdateFailure extends HomeState {
  const HomeUpdateFailure({
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

class HomeSearchInputUpdateFailure extends HomeState {
  const HomeSearchInputUpdateFailure({
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
