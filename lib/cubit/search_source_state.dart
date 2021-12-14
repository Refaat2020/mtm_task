part of 'search_source_cubit.dart';

abstract class SearchSourceState extends Equatable {
  const SearchSourceState();
}

class SearchSourceInitial extends SearchSourceState {
  @override
  List<Object> get props => [];
}

class SearchSourceLoading extends SearchSourceState {
  @override
  List<Object> get props => [];
}
class SearchSourceFetched extends SearchSourceState {
  final List<QueryDocumentSnapshot>places;

  const SearchSourceFetched({required this.places});

  @override
  List<Object> get props => [];
}

class SourcePlaceSelected extends SearchSourceState {
  @override
  List<Object> get props => [];
}
