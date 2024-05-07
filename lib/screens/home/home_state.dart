part of 'home_notifier.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSuccessUpdate extends HomeState {
  const HomeSuccessUpdate({
    required this.offers,
  });

  final List<Offer> offers;

  @override
  List<Object?> get props => [
        offers,
      ];
}

class HomeSearchInputUpdate extends HomeState {
  const HomeSearchInputUpdate({
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
