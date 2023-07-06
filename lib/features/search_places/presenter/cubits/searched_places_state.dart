part of 'searched_places_cubit.dart';

@immutable
/// Stores the state of loading, more loading and searched places
class SearchedPlacesState {
  const SearchedPlacesState({
    this.loading = false,
    this.moreLoading = false,
    this.searchedPlaces = const [],
  });

  final bool loading;
  final bool moreLoading;
  final List<Address> searchedPlaces;

  SearchedPlacesState copyWith({
    bool? loading,
    bool? moreLoading,
    List<Address>? searchedPlaces,
  }) {
    return SearchedPlacesState(
      loading: loading ?? this.loading,
      moreLoading: moreLoading ?? this.moreLoading,
      searchedPlaces: searchedPlaces ?? this.searchedPlaces,
    );
  }
}
