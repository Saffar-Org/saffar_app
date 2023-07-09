import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:saffar_app/core/utils/snackbar.dart';
import 'package:saffar_app/features/search_places_and_get_route/domain/usecases/get_address_from_lat_lon_usecase.dart';
import 'package:saffar_app/features/search_places_and_get_route/domain/usecases/get_searched_addresses_usecase.dart';

import '../../../../core/models/address.dart';

part 'searched_places_state.dart';

class SearchedPlacesCubit extends Cubit<SearchedPlacesState> {
  SearchedPlacesCubit() : super(const SearchedPlacesState());

  final GetSearchedAddressesUsecase _getSearchedAddressesUsecase =
      GetSearchedAddressesUsecase();
  final GetAddressFromLatLon _getAddressFromLatLon = GetAddressFromLatLon();

  /// Search places and emit the searched places. If Failure then
  /// show SnackBar message.
  void searchPlaces(
    BuildContext context,
    String searchText,
  ) async {
    emit(state.copyWith(loading: true));

    final result = await _getSearchedAddressesUsecase(searchText);

    final List<Address> searchedPlaces = [];

    result.fold(
      (l) {
        if (l.code != 'TOO_MANY_QUERIES_PER_SECOND') {
          Snackbar.of(context)
              .show(l.message ?? 'Failed to load searched places');
        }
      },
      (r) {
        searchedPlaces.addAll(r);
      },
    );

    emit(SearchedPlacesState(searchedPlaces: searchedPlaces));
  }

  /// Add more places to the already searched places. If Failure then
  /// show SnackBar message.
  void searchMorePlaces(
    BuildContext context,
    String searchText,
  ) async {
    emit(state.copyWith(moreLoading: true));

    final result = await _getSearchedAddressesUsecase(searchText);

    final List<Address> searchedPlaces = state.searchedPlaces.toList();

    result.fold(
      (l) {
        Snackbar.of(context)
            .show(l.message ?? 'Failed to load searched places');
      },
      (r) {
        searchedPlaces.addAll(r);
      },
    );

    emit(SearchedPlacesState(searchedPlaces: searchedPlaces));
  }

  /// Gets Address from lat and lon and emits 
  /// text field loading when address is being fetched
  Future<Address?> getAddressFromLatLon(
    BuildContext context,
    double lat,
    double lon,
  ) async {
    emit(state.copyWith(textFieldLoading: true));

    final result = await _getAddressFromLatLon.call(lat, lon);

    Address? address;

    result.fold(
      (l) {
        if (l.code == 'NO_PLACE_FOUND' && l.message != null) {
          Snackbar.of(context).show(l.message!);
        }
      },
      (r) {
        address = r;
      },
    );

    emit(state.copyWith(textFieldLoading: false));

    return address;
  }
}
