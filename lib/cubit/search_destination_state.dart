part of 'search_destination_cubit.dart';

abstract class SearchDestinationState extends Equatable {
  const SearchDestinationState();
}

class SearchDestinationInitial extends SearchDestinationState {
  @override
  List<Object> get props => [];
}

class SearchDestinationLoading extends SearchDestinationState {
  @override
  List<Object> get props => [];
}
class SearchDestinationFetched extends SearchDestinationState {
 final List<CityModelEntity>city;


  SearchDestinationFetched({required this.city});

  @override
  List<Object> get props => [];
}

