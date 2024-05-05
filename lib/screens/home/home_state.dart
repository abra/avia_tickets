part of 'home_notifier.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSuccess extends HomeState {
  const HomeSuccess({
    required this.offers,
  });

  final List<Offer> offers;

  @override
  List<Object?> get props => [
    offers,
  ];
}

// part of 'map_location_notifier.dart';
//
// sealed class MapLocationState extends Equatable {
//   const MapLocationState();
// }
//
// class MapInitialLocationUpdate extends MapLocationState {
//   @override
//   List<Object?> get props => [];
// }
//
// class MapLocationUpdateSuccess extends MapLocationState {
//   const MapLocationUpdateSuccess({
//     required this.location,
//   });
//
//   final Location location;
//
//   @override
//   List<Object?> get props => [
//     location,
//   ];
// }
//
// class MapLocationUpdateFailure extends MapLocationState {
//   const MapLocationUpdateFailure({
//     required this.error,
//   }) : errorMessage = '$error';
//
//   final dynamic error;
//   final String errorMessage;
//
//   @override
//   List<Object?> get props => [
//     error,
//     errorMessage,
//   ];
// }
