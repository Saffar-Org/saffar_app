part of 'searched_places_cubit.dart';

@immutable
/// Stores the state of loading, more loading, searched places and 
/// text field loading
class SearchedPlacesState {
  const SearchedPlacesState({
    this.loading = false,
    this.moreLoading = false,
    this.searchedPlaces = const [],
    this.textFieldLoading = false,
  });

  final bool loading;
  final bool moreLoading;
  final List<Address> searchedPlaces;
  final bool textFieldLoading;

  SearchedPlacesState copyWith({
    bool? loading,
    bool? moreLoading,
    List<Address>? searchedPlaces,
    bool? textFieldLoading,
  }) {
    return SearchedPlacesState(
      loading: loading ?? this.loading,
      moreLoading: moreLoading ?? this.moreLoading,
      searchedPlaces: searchedPlaces ?? this.searchedPlaces,
      textFieldLoading: textFieldLoading ?? this.textFieldLoading,
    );
  }
}
