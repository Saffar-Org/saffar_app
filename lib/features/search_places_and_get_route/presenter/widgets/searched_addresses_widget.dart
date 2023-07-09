import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saffar_app/core/models/address.dart';
import 'package:saffar_app/core/widgets/address_widget.dart';
import 'package:saffar_app/features/search_places_and_get_route/presenter/cubits/searched_places_cubit.dart';

class SearchedAddressesWidget extends StatelessWidget {
  const SearchedAddressesWidget({
    Key? key,
    required this.onAddressSelected,
  }) : super(key: key);

  final Function(Address) onAddressSelected;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<SearchedPlacesCubit, SearchedPlacesState>(
      builder: (context, state) {
        if (state.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: colorScheme.primary,
            ),
          );
        } else {
          return state.searchedPlaces.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(
                    bottom: 40,
                  ),
                  child: Center(
                    child: Text('No places searched'),
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.searchedPlaces.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.searchedPlaces.length) {
                      return const SizedBox(height: 16);
                    }

                    final Address address = state.searchedPlaces[index];

                    return InkWell(
                      onTap: () {
                        onAddressSelected(address);
                      },
                      child: AddressWidget(
                        address: address,
                        showDivider: index != (state.searchedPlaces.length - 1),
                      ),
                    );
                  },
                );
        }
      },
    );
  }
}
